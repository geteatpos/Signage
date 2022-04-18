import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/validator.dart';
import 'signin_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 48.0),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(Icons.email),
                      labelText: 'auth.emailFormField'.tr,
                    ),
                    controller: authController.emailController,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) =>
                        authController.emailController.text = value as String,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await authController.sendPasswordResetEmail(context);
                      }
                    },
                    child: Text(
                      'auth.resetPasswordButton'.tr.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  signInLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    if (authController.emailController.text == '') {
      return null;
    }
    return AppBar(title: Text('auth.resetPasswordTitle'.tr));
  }

  signInLink(BuildContext context) {
    if (authController.emailController.text == '') {
      return TextButton(
        child: Text(
          'auth.signInonResetPasswordLabelButton'.tr,
        ),
        onPressed: () => Get.offAll(SigninScreen()),
      );
    }
    return const SizedBox(width: 0, height: 0);
  }
}
