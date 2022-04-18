import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../controllers/main_controller.dart';

class AddDevice extends StatefulWidget {
  final String restaurantId;
  final String grupoId;
  const AddDevice({
    Key? key,
    required this.restaurantId,
    required this.grupoId,
  }) : super(key: key);

  @override
  State<AddDevice> createState() => _AddDeviceState();
}

class _AddDeviceState extends State<AddDevice> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerId = TextEditingController();

  @override
  void dispose() {
    _controllerName.dispose();
    _controllerId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Device"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _controllerName,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  hintText: "Name",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _controllerId,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: 'Device Id',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  hintText: "Device Id",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_controllerName.text.trim().isNotEmpty) {
                    MainController.to.addDevice(
                      widget.restaurantId,
                      widget.grupoId,
                      _controllerName.text.trim(),
                      _controllerId.text.trim(),
                    );
                    Get.back();
                  }
                },
                child: const Text("Save"),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: QrImage(
                  data: GetStorage().read("deviceId"),
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
