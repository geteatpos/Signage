import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../componentes/restaurant/restaurant_list.dart';
import '../componentes/restaurant/restaurant_list_byid.dart';
import '../models/user_model.dart';
import '../services/firestore_db.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home.title'.tr + ' signage'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.toNamed("/settings");
            },
          ),
        ],
      ),
      body: StreamBuilder<UserModel>(
        stream: FirestoreDB().streamUser(),
        builder: (context, snapshotUser) {
          if (snapshotUser.connectionState == ConnectionState.active) {
            var userModel = snapshotUser.data!;
            return userModel.role == "Super"
                ? const RestaurantList()
                : RestaurantById(
                    restaurantId: snapshotUser.data!.restaurantDefault,
                  );
          }
          return const Scaffold(
            body: Center(
              child: SpinKitWanderingCubes(
                size: 50,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}
