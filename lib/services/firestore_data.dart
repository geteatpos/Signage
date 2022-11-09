import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/data_model.dart';

class FirestoreData {
  static final _fireStoreDataCollection =
      FirebaseFirestore.instance.collection("signageData");

  static Stream<List<DataModel>> streamDataDisplay(
      String restaurantId, String gropuId) {
    return _fireStoreDataCollection
        .doc(restaurantId)
        .collection('grupos')
        .doc(gropuId)
        .collection('items')
        .snapshots()
        .map((media) {
      final List<DataModel> list = [];
      for (final DocumentSnapshot<Map<String, dynamic>> doc in media.docs) {
        list.add(DataModel.fromDocumentSnapshot(doc: doc));
      }
      return list;
    });
  }

  static Future<void> addData(
      String restaurantId, String gropuId, String mediaType, File photo) async {
    String mediaUrl = await uploadImageToStorage('signage', photo);

    await _fireStoreDataCollection
        .doc(restaurantId)
        .collection('grupos')
        .doc(gropuId)
        .collection('items')
        .doc()
        .set({
      'mediaType': mediaType,
      'mediaUrl': mediaUrl,
    });
  }

  static void deleteData(String restaurantId, String gropuId, String dataId) {
    _fireStoreDataCollection
        .doc(restaurantId)
        .collection('grupos')
        .doc(gropuId)
        .collection('items')
        .doc(dataId)
        .delete();
  }

  static Future<String> uploadImageToStorage(String folder, File file) async {
    String id = const Uuid().v1();

    Reference ref =
        FirebaseStorage.instance.ref().child(folder).child("$id.png");

    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot taskSnapshot = await uploadTask;

    return await taskSnapshot.ref.getDownloadURL();
  }
}
