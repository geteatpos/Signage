import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:signage/models/device_info_model.dart';
import 'package:uuid/uuid.dart';

import '../models/data_model.dart';
import '../models/device_model.dart';
import '../models/grupo_model.dart';
import '../models/restaurant_model.dart';
import '../models/user_model.dart';

class MainController extends GetxController {
  static MainController to = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<UserModel> streamUser() {
    return firestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((user) {
      return UserModel.fromDocumentSnapshot(doc: user);
    });
  }

  Stream<DeviceInfoModel> streamDeviceInfo(String deviceId) {
    return firestore
        .collection('signageDevices')
        .doc(deviceId)
        .snapshots()
        .map((device) {
      return DeviceInfoModel.fromDocumentSnapshot(doc: device);
    });
  }

  Stream<List<RestaurantModel>> streamRestaurants() {
    return firestore.collection('restaurants').snapshots().map((restaurants) {
      final List<RestaurantModel> list = [];
      for (final DocumentSnapshot<Map<String, dynamic>> doc
          in restaurants.docs) {
        list.add(RestaurantModel.fromDocumentSnapshot(doc: doc));
      }
      return list;
    });
  }

  Stream<RestaurantModel> streamRestaurantById(String restaurantId) {
    return firestore
        .collection('restaurants')
        .doc(restaurantId)
        .snapshots()
        .map((restaurant) {
      return RestaurantModel.fromDocumentSnapshot(doc: restaurant);
    });
  }

  Stream<List<GrupoModel>> streamGrupos(String restaurantId) {
    return firestore
        .collection('signageGrupos')
        .doc(restaurantId)
        .collection('items')
        .snapshots()
        .map((grupos) {
      final List<GrupoModel> list = [];
      for (final DocumentSnapshot<Map<String, dynamic>> doc in grupos.docs) {
        list.add(GrupoModel.fromDocumentSnapshot(doc: doc));
      }
      return list;
    });
  }

  Future<void> addGrupo(String restaurantId, String name) async {
    await FirebaseFirestore.instance
        .collection('signageGrupos')
        .doc(restaurantId)
        .collection('items')
        .doc()
        .set({
      'name': name,
    });
  }

  Stream<List<DeviceModel>> streamDevices(String restaurantId, String gropuId) {
    return firestore
        .collection('signageGrupos')
        .doc(restaurantId)
        .collection('items')
        .doc(gropuId)
        .collection('devices')
        .snapshots()
        .map((devices) {
      final List<DeviceModel> list = [];
      for (final DocumentSnapshot<Map<String, dynamic>> doc in devices.docs) {
        list.add(DeviceModel.fromDocumentSnapshot(doc: doc));
      }
      return list;
    });
  }

  Future<void> addDevice(
      String restaurantId, String gropuId, String name, String deviceId) async {
    await FirebaseFirestore.instance
        .collection('signageGrupos')
        .doc(restaurantId)
        .collection('items')
        .doc(gropuId)
        .collection('devices')
        .doc()
        .set({
      'name': name,
      'deviceId': deviceId,
    });

    await FirebaseFirestore.instance
        .collection('signageDevices')
        .doc(deviceId)
        .set({
      'restaurantId': restaurantId,
      'grupoId': gropuId,
    });
  }

  Stream<List<DataModel>> streamDataDisplay(
      String restaurantId, String gropuId) {
    return firestore
        .collection('signageData')
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

  Future<void> addData(String restaurantId, String gropuId, String mediaType,
      File _photo) async {
    String mediaUrl = await uploadImageToStorage('signage', _photo);

    await FirebaseFirestore.instance
        .collection('signageData')
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

  Future<String> uploadImageToStorage(String folder, File file) async {
    String id = const Uuid().v1();

    Reference ref =
        FirebaseStorage.instance.ref().child(folder).child("$id.png");

    UploadTask uploadTask = ref.putFile(file);

    TaskSnapshot taskSnapshot = await uploadTask;

    return await taskSnapshot.ref.getDownloadURL();
  }
}
