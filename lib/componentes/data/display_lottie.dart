import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../models/data_model.dart';

class DisplayLottie extends StatelessWidget {
  final DataModel item;
  const DisplayLottie({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.network(item.mediaUrl);
  }
}
