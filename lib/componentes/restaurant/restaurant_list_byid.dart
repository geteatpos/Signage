import 'package:flutter/material.dart';
import 'package:signages/controllers/main_controller.dart';

import '../../models/restaurant_model.dart';
import 'restaurant_row.dart';

class RestaurantById extends StatelessWidget {
  final String restaurantId;
  const RestaurantById({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RestaurantModel>(
      stream: MainController.to.streamRestaurantById(restaurantId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return GestureDetector(
            onTap: () {},
            child: RestaurantRow(
              restaurant: snapshot.data!,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
