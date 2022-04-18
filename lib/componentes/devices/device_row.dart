import 'package:flutter/material.dart';
import 'package:signages/models/device_model.dart';

class DeviceRow extends StatelessWidget {
  final DeviceModel device;
  const DeviceRow({
    Key? key,
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
          onPressed: () {},
        ),
      ),
    );
  }
}
