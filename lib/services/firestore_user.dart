import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class FirestoreUser {
  static final _fireStoreUserCollection =
      FirebaseFirestore.instance.collection("users");

  static Stream<UserModel> streamUser() {
    return _fireStoreUserCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((user) {
      return UserModel.fromDocumentSnapshot(doc: user);
    });
  }
}
