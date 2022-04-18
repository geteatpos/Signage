import 'package:cloud_firestore/cloud_firestore.dart';

class GrupoModel {
  String id;
  String name;

  GrupoModel({
    required this.id,
    required this.name,
  });

  factory GrupoModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> doc}) {
    return GrupoModel(
      id: doc.id,
      name: doc.data()!["name"],
    );
  }
}
