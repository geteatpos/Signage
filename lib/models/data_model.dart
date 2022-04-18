import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  String id;
  String mediaType;
  String mediaUrl;

  DataModel({
    required this.id,
    required this.mediaType,
    required this.mediaUrl,
  });

  factory DataModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return DataModel(
      id: doc.id,
      mediaType: doc.data()!["mediaType"],
      mediaUrl: doc.data()!["mediaUrl"],
    );
  }
}
