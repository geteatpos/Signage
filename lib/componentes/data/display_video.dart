import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../models/data_model.dart';

class DisplayVideo extends StatefulWidget {
  final DataModel item;
  const DisplayVideo({
    super.key,
    required this.item,
  });

  @override
  State<DisplayVideo> createState() => _DisplayVideoState();
}

class _DisplayVideoState extends State<DisplayVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.item.mediaUrl);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  Future<bool> started() async {
    await _controller.initialize();
    await _controller.setLooping(true);
    await _controller.play();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: started(),
      builder: (context, snapshot) {
        if (snapshot.data ?? false) {
          return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
