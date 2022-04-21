import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _controllerId.text = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Device"),
        actions: [
          IconButton(
            onPressed: () => scanQR(),
            icon: const Icon(Icons.qr_code_scanner),
          ),
          IconButton(
            onPressed: () {
              _controllerId.text = GetStorage().read("deviceId");
            },
            icon: const Icon(Icons.paste),
          ),
        ],
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
            ],
          ),
        ),
      ),
    );
  }
}
