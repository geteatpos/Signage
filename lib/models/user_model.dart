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
    return UserModel(
      id: doc.id,
      name: doc.data()!["name"],
      email: doc.data()!["email"],
      restaurantDefault: doc.data()!["restaurantDefault"],
      role: doc.data()!["role"],
    );
  }
}
