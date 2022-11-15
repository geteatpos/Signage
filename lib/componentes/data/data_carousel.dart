import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:signage/componentes/data/display_lottie.dart';
import 'package:signage/componentes/data/display_video.dart';
import 'package:signage/models/data_model.dart';

import 'display_image.dart';

class DataCarousel extends StatelessWidget {
  final List<DataModel> listMedia;
  const DataCarousel({
    Key? key,
    required this.listMedia,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return CarouselSlider(
      options: CarouselOptions(
        height: height,
        autoPlay: true,
        viewportFraction: 1.0,
        autoPlayInterval: const Duration(seconds: 15),
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
      ),
      items: listMedia.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return (item.mediaType == "lottie")
                ? DisplayLottie(item: item)
                : (item.mediaType == "video")
                    ? DisplayVideo(item: item)
                    : DisplayImage(item: item);
          },
        );
      }).toList(),
    );
  }
}
