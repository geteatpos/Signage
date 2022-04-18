import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signages/controllers/main_controller.dart';
import 'package:signages/models/device_info_model.dart';
import 'package:signages/screens/home_screen.dart';

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
                        var dato = dataList[index];
                        return CarouselSlider(
                          options: CarouselOptions(height: 400.0),
                          items: dataList.map((item) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration:
                                      const BoxDecoration(color: Colors.amber),
                                  child: const Placeholder(),
                                );
                              },
                            );
                          }).toList(),
                        );
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
