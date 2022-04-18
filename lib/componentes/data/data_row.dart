import 'package:flutter/material.dart';
import 'package:signage/models/data_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DataWidgetRow extends StatelessWidget {
  final DataModel dato;
  const DataWidgetRow({
    Key? key,
    required this.dato,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(
            dato.mediaUrl,
          ),
        ),
        title: Text(
          dato.mediaType,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {},
        ),
      ),
    );
  }
}
