import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../componentes/data/data_carousel.dart';
import '../models/data_model.dart';
import '../models/device_info_model.dart';
import '../services/firestore_db.dart';
import '../utils/globals.dart';
import 'home_screen.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(GetStorage().read("deviceId"));
    return Scaffold(
      body: InkWell(
        onTap: () async {
          var isTv = await Globals.isTV();

          if (!isTv) {
            Get.to(() => const HomeScreen());
          }
        },
        child: StreamBuilder<DeviceInfoModel>(
          stream: FirestoreDB().streamDeviceInfo(GetStorage().read('deviceId')),
          builder: (context, snapshotDeviceInfo) {
            if (snapshotDeviceInfo.connectionState == ConnectionState.active) {
              if (snapshotDeviceInfo.hasData) {
                var deviceInfo = snapshotDeviceInfo.data!;
                return StreamBuilder<List<DataModel>>(
                  stream: FirestoreDB().streamDataDisplay(
                      deviceInfo.restaurantId, deviceInfo.grupoId),
                  builder: (context, snapshotData) {
                    if (snapshotData.connectionState ==
                        ConnectionState.active) {
                      var dataList = snapshotData.data!;
                      return ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return DataCarousel(listMedia: dataList);
                        },
                      );
                    }
                    return const Center(
                      child: SpinKitWanderingCubes(
                        size: 50,
                        color: Colors.black,
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QrImage(
                        data: GetStorage().read("deviceId"),
                        version: QrVersions.auto,
                        size: 200.0,
                      ),
                      Text(
                        GetStorage().read("deviceId"),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
            return const Scaffold(
              body: Center(
                child: SpinKitWanderingCubes(
                  size: 50,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
