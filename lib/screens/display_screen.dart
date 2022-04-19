import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signage/componentes/data/data_carousel.dart';
import 'package:signage/controllers/main_controller.dart';
import 'package:signage/models/device_info_model.dart';
import 'package:signage/screens/home_screen.dart';

import '../models/data_model.dart';

class DisplayScreen extends StatelessWidget {
  const DisplayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Get.to(() => const HomeScreen());
        },
        child: StreamBuilder<DeviceInfoModel>(
          stream:
              MainController.to.streamDeviceInfo(GetStorage().read('deviceId')),
          builder: (context, snapshotDeviceInfo) {
            if (snapshotDeviceInfo.connectionState == ConnectionState.active) {
              var deviceInfo = snapshotDeviceInfo.data!;
              return StreamBuilder<List<DataModel>>(
                stream: MainController.to.streamDataDisplay(
                    deviceInfo.restaurantId, deviceInfo.grupoId),
                builder: (context, snapshotData) {
                  if (snapshotData.connectionState == ConnectionState.active) {
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
                    child: CircularProgressIndicator(),
                  );
                },
              );
            }
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
