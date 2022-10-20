import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String restaurantDefault;
  String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.restaurantDefault,
    required this.role,
  });

  factory UserModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    var user = doc.data()!;
    return UserModel(
      id: doc.id,
      name: user["name"] ?? "",
      email: user["email"] ?? "",
      restaurantDefault: user["restaurantDefault"] ?? "",
      role: user["role"] ?? "",
    );
  }
}
