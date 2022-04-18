import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signage/controllers/main_controller.dart';
import 'package:signage/models/grupo_model.dart';

import '../componentes/grupo/grupo_add.dart';
import '../componentes/grupo/grupo_row.dart';

class GrupoScreen extends StatelessWidget {
  final String restaurantId;
  const GrupoScreen({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grupos")),
      body: StreamBuilder<List<GrupoModel>>(
        stream: MainController.to.streamGrupos(restaurantId),
        builder: (context, snapshotGrupos) {
          if (snapshotGrupos.connectionState == ConnectionState.active) {
            var grupos = snapshotGrupos.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: grupos.length,
              itemBuilder: (context, index) {
                return GrupoRow(
                  restaurantId: restaurantId,
                  grupo: grupos[index],
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
        label: const Text('Add Group'),
        elevation: 1,
        backgroundColor: Colors.pink,
        onPressed: () {
          Get.to(() => AddGrupo(restaurantId: restaurantId));
        },
      ),
    );
  }
}
