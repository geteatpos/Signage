import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/grupo_model.dart';

class FirestoreGrupo {
  static final _fireStoreGrupoCollection =
      FirebaseFirestore.instance.collection("signageGrupos");

  static Stream<List<GrupoModel>> streamGrupos(String restaurantId) {
    return _fireStoreGrupoCollection
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

  static Future<void> addGrupo(String restaurantId, String name) async {
    await _fireStoreGrupoCollection
        .doc(restaurantId)
        .collection('items')
        .doc()
        .set({
      'name': name,
    });
  }

  static void deleteGrupo(String restaurantId, String gropuId) {
    _fireStoreGrupoCollection
        .doc(restaurantId)
        .collection('items')
        .doc(gropuId)
        .delete();
  }
}
