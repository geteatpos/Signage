import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signage/services/firestore_device.dart';

import '../../models/device_model.dart';

class DeviceRow extends StatelessWidget {
  final String restaurantId;
  final String gropuId;
  final DeviceModel device;
  const DeviceRow({
    Key? key,
    required this.restaurantId,
    required this.gropuId,
    required this.device,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              device.name,
            ),
            Text(
              device.deviceId,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
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
                  FirestoreDevice.deleteDevice(
                      restaurantId, gropuId, device.id);
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
