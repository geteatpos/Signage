import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceModel {
  String id;
  String name;
  String deviceId;

  DeviceModel({
    required this.id,
    required this.name,
    required this.deviceId,
  });

  factory DeviceModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return DeviceModel(
      id: doc.id,
      name: doc.data()!["name"],
      deviceId: doc.data()!["deviceId"],
    );
  }
}
