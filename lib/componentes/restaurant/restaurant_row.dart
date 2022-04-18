import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signage/screens/grupo_screen.dart';

import '../../models/restaurant_model.dart';

class RestaurantRow extends StatelessWidget {
  final RestaurantModel restaurant;
  const RestaurantRow({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: ListTile(
        leading: IconButton(
          icon: const Icon(Icons.ac_unit),
          onPressed: () => Get.to(() => GrupoScreen(
                restaurantId: restaurant.id,
              )),
        ),
        title: Text(
          restaurant.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
