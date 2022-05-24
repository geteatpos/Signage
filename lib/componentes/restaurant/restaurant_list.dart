import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../models/restaurant_model.dart';
import '../../services/firestore_db.dart';
import 'restaurant_row.dart';

class RestaurantList extends StatelessWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RestaurantModel>>(
      stream: FirestoreDB().streamRestaurants(),
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
          child: SpinKitWanderingCubes(
            size: 50,
            color: Colors.black,
          ),
        );
      },
    );
  }
}
