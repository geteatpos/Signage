import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/validator.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({
    Key? key,
  }) : super(key: key);

  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        authController.emailController.text = value!,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      prefixIcon: const Icon(Icons.lock),
                      labelText: 'auth.passwordFormField'.tr,
                    ),
                    controller: authController.passwordController,
                    validator: Validator().password,
                    obscureText: true,
                    onSaved: (value) =>
                        authController.passwordController.text = value!,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        authController.signInWithEmailAndPassword(context);
                      }
                    },
                    child: Text(
                      'auth.signInButton'.tr.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextButton(
                    child: Text(
                      'auth.resetPasswordLabelButton'.tr,
                    ),
                    onPressed: () {
                      Get.toNamed("/reset-password");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
