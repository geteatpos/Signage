import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../models/data_model.dart';

class DisplayLottie extends StatefulWidget {
  final DataModel item;
  const DisplayLottie({
    super.key,
    required this.item,
  });

  @override
  State<DisplayLottie> createState() => _DisplayLottieState();
}

class _DisplayLottieState extends State<DisplayLottie>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.network(
      widget.item.mediaUrl,
      controller: _controller,
      onLoaded: (composition) {
        _controller
          ..duration = composition.duration
          ..forward();
      },
    );
  }
}
