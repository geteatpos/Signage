import 'package:flutter/material.dart';
import 'package:signage/widgets/custom_spinner.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CustomSpinner(),
      ),
    );
  }
}
