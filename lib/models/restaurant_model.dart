import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  String id;
  String name;
  String city;
  String contacto;
  String phone;
  String locationID;
  String logoUrl;
  String publicidadUrl;
  int tipperCent;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.city,
    required this.contacto,
    required this.phone,
    required this.locationID,
    required this.logoUrl,
    required this.publicidadUrl,
    required this.tipperCent,
  });

  factory RestaurantModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return RestaurantModel(
      id: doc.id,
      name: doc.data()!["name"],
      city: doc.data()!["city"],
      contacto: doc.data()!["contacto"],
      phone: doc.data()!["phone"],
      locationID: doc.data()!["locationID"],
      logoUrl: doc.data()!["logoUrl"],
      publicidadUrl: doc.data()!["publicidadUrl"],
      tipperCent: doc.data()!["tipperCent"],
    );
  }
}
