import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signage/screens/display_screen.dart';
import 'package:signage/utils/globals.dart';

import '../models/user_model.dart';
import '../screens/signin_screen.dart';
import '../widgets/loading.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  late Rx<User?> firebaseUser;

  @override
  void onReady() async {
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);

    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      var isTv = await Globals.isTV();
      if (isTv) {
        signInAnonymously();
      } else {
        Get.offAll(() => SigninScreen());
      }
    } else {
      Get.offAll(() => const DisplayScreen());
    }
  }

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
      await auth.signInWithEmailAndPassword(
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

  signInAnonymously() async {
    showLoadingIndicator();
    try {
      await auth.signInAnonymously();
      hideLoadingIndicator();
    } catch (error) {
      hideLoadingIndicator();
    }
  }

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    showLoadingIndicator();
    try {
      await auth.sendPasswordResetEmail(email: emailController.text);
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

  // Sign out
  Future<void> signOut() {
    emailController.clear();
    passwordController.clear();
    return auth.signOut();
  }
}
