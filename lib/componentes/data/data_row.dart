import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signage/models/data_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:signage/services/firestore_data.dart';

class DataWidgetRow extends StatelessWidget {
  final String restaurantId;
  final String gropuId;
  final DataModel dato;
  const DataWidgetRow({
    Key? key,
    required this.restaurantId,
    required this.gropuId,
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
          onPressed: () {
            Get.defaultDialog(
              title: "Danger",
              textConfirm: "Confirm",
              textCancel: "Cancel",
              middleText: "Are you sure to delete this item?",
              cancel: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text("Cancel"),
              ),
              confirm: ElevatedButton(
                onPressed: () {
                  FirestoreData.deleteData(restaurantId, gropuId, dato.id);
                  Get.back();
                },
                child: const Text("Confirm"),
              ),
            );
          },
        ),
      ),
    );
  }
}
