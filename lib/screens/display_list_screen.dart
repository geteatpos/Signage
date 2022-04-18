import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signage/componentes/devices/device_add.dart';

import '../componentes/devices/device_row.dart';
import '../controllers/main_controller.dart';
import '../models/device_model.dart';

class DisplayListScreen extends StatelessWidget {
  final String restaurantId;
  final String grupoId;
  const DisplayListScreen({
    Key? key,
    required this.restaurantId,
    required this.grupoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display List"),
      ),
      body: StreamBuilder<List<DeviceModel>>(
        stream: MainController.to.streamDevices(restaurantId, grupoId),
        builder: (context, snapshotDevices) {
          if (snapshotDevices.connectionState == ConnectionState.active) {
            var devices = snapshotDevices.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: devices.length,
              itemBuilder: (context, index) {
                var device = devices[index];
                return DeviceRow(
                  device: device,
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Device'),
        elevation: 1,
        backgroundColor: Colors.pink,
        onPressed: () {
          Get.to(() => AddDevice(
                restaurantId: restaurantId,
                grupoId: grupoId,
              ));
        },
      ),
    );
  }
}
