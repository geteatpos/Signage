import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SpinKitWanderingCubes(
      size: 50,
      color: Colors.black,
    );
  }
}
