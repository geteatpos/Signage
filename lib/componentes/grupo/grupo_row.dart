import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signage/models/grupo_model.dart';
import 'package:signage/screens/data_list_screen.dart';

import '../../screens/display_list_screen.dart';

class GrupoRow extends StatelessWidget {
  final String restaurantId;
  final GrupoModel grupo;
  const GrupoRow({
    Key? key,
    required this.grupo,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          grupo.name,
        ),
        trailing: PopupMenuButton(
          onSelected: (int index) {
            if (index == 1) {
              Get.to(() => DataListScreen(
                    restaurantId: restaurantId,
                    grupoId: grupo.id,
                  ));
            } else if (index == 2) {
              Get.to(() => DisplayListScreen(
                    restaurantId: restaurantId,
                    grupoId: grupo.id,
                  ));
            } else {}
          },
          itemBuilder: (context) => const [
            PopupMenuItem(
              child: Text("Data"),
              value: 1,
            ),
            PopupMenuItem(
              child: Text("Devices"),
              value: 2,
            ),
            PopupMenuItem(
              child: Text("Edit"),
              value: 3,
            ),
          ],
        ),
      ),
    );
  }
}
