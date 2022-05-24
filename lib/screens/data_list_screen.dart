import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../componentes/data/data_add.dart';
import '../componentes/data/data_row.dart';
import '../models/data_model.dart';
import '../services/firestore_db.dart';

class DataListScreen extends StatelessWidget {
  final String restaurantId;
  final String grupoId;
  const DataListScreen({
    Key? key,
    required this.restaurantId,
    required this.grupoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display Data"),
      ),
      body: StreamBuilder<List<DataModel>>(
        stream: FirestoreDB().streamDataDisplay(restaurantId, grupoId),
        builder: (context, snapshotData) {
          if (snapshotData.connectionState == ConnectionState.active) {
            var dataList = snapshotData.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                var dato = dataList[index];
                return DataWidgetRow(
                  restaurantId: restaurantId,
                  gropuId: grupoId,
                  dato: dato,
                );
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Data'),
        elevation: 1,
        backgroundColor: Colors.pink,
        onPressed: () {
          Get.to(() => DataAddScreen(
                restaurantId: restaurantId,
                grupoId: grupoId,
              ));
        },
      ),
    );
  }
}
