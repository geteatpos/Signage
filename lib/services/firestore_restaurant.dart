import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/restaurant_model.dart';

class FirestoreRestaurant {
  static final _fireStoreRestaurantCollection =
      FirebaseFirestore.instance.collection("restaurants");

  static Stream<List<RestaurantModel>> streamRestaurants() {
    return _fireStoreRestaurantCollection.snapshots().map((restaurants) {
      final List<RestaurantModel> list = [];
      for (final DocumentSnapshot<Map<String, dynamic>> doc
          in restaurants.docs) {
        list.add(RestaurantModel.fromDocumentSnapshot(doc: doc));
      }
      return list;
    });
  }

  static Stream<RestaurantModel> streamRestaurantById(String restaurantId) {
    return _fireStoreRestaurantCollection
        .doc(restaurantId)
        .snapshots()
        .map((restaurant) {
      return RestaurantModel.fromDocumentSnapshot(doc: restaurant);
    });
  }
}
