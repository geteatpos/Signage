import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';
import '../screens/home_screen.dart';
import '../screens/signin_screen.dart';
import '../widgets/loading.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Rxn<User> firebaseUser = Rxn<User>();

  Rxn<UserModel> firestoreUser = Rxn<UserModel>();

  final RxBool admin = false.obs;

  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);

    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
      await isAdmin();
    }

    if (_firebaseUser == null) {
      debugPrint('Send to signin');
      Get.offAll(SigninScreen());
    } else {
      Get.offAll(const HomeScreen());
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => _auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    debugPrint('streamFirestoreUser()');

    return _db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromDocumentSnapshot(doc: snapshot));
  }

  Future<UserModel> getFirestoreUser() {
    return _db.doc('/users/${firebaseUser.value!.uid}').get().then(
        (documentSnapshot) =>
            UserModel.fromDocumentSnapshot(doc: documentSnapshot));
  }

  signInWithEmailAndPassword(BuildContext context) async {
    showLoadingIndicator();
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
      hideLoadingIndicator();
    } catch (error) {
      hideLoadingIndicator();
      Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    showLoadingIndicator();
    try {
      await _auth.sendPasswordResetEmail(email: emailController.text);
      hideLoadingIndicator();
      Get.snackbar(
          'auth.resetPasswordNoticeTitle'.tr, 'auth.resetPasswordNotice'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    } on FirebaseAuthException catch (error) {
      hideLoadingIndicator();
      Get.snackbar('auth.resetPasswordFailed'.tr, error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  isAdmin() async {
    await getUser.then((user) async {
      DocumentSnapshot adminRef =
          await _db.collection('admin').doc(user.uid).get();
      if (adminRef.exists) {
        admin.value = true;
      } else {
        admin.value = false;
      }
      update();
    });
  }

  // Sign out
  Future<void> signOut() {
    emailController.clear();
    passwordController.clear();
    return _auth.signOut();
  }
}
