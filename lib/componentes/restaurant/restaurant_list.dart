import 'package:flutter/material.dart';
import 'package:signage/controllers/main_controller.dart';

import '../../models/restaurant_model.dart';
import 'restaurant_row.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RestaurantModel>>(
      stream: MainController.to.streamRestaurants(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: RestaurantRow(
                  restaurant: snapshot.data![index],
                ),
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
}
