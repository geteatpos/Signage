import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:signage/models/data_model.dart';

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
        enlargeCenterPage: false,
      ),
      items: listMedia.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: item.mediaUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: item.mediaUrl,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const SpinKitWanderingCubes(
                        size: 50,
                        color: Colors.black,
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Image.asset("assets/images/no-image-found.png"),
            );
          },
        );
      }).toList(),
    );
  }
}
