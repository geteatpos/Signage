import 'package:cloud_firestore/cloud_firestore.dart';

class DeviceInfoModel {
  String id;
  String grupoId;
  String restaurantId;

  DeviceInfoModel({
    required this.id,
    required this.grupoId,
    required this.restaurantId,
  });

  factory DeviceInfoModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return DeviceInfoModel(
      id: doc.id,
      grupoId: doc.data()!["grupoId"],
      restaurantId: doc.data()!["restaurantId"],
    );
  }
}
