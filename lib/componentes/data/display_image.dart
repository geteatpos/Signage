import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/data_model.dart';

class DisplayImage extends StatelessWidget {
  final DataModel item;
  const DisplayImage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
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
              placeholder: (context, url) => const SpinKitWanderingCubes(
                size: 50,
                color: Colors.black,
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : Image.asset("assets/images/no-image-found.png"),
    );
  }
}
