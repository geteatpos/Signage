import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:signage/controllers/main_controller.dart';

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
          child: SpinKitWanderingCubes(
            size: 50,
            color: Colors.black,
          ),
        );
      },
    );
  }
}
