import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/device_info_model.dart';
import '../models/device_model.dart';

class FirestoreDevice {
  static final _fireStoreDeviceCollection =
      FirebaseFirestore.instance.collection("signageDevices");

  static final _fireStoreGrupoCollection =
      FirebaseFirestore.instance.collection("signageGrupos");

  static Stream<DeviceInfoModel> streamDeviceInfo(String deviceId) {
    return _fireStoreDeviceCollection.doc(deviceId).snapshots().map((device) {
      return DeviceInfoModel.fromDocumentSnapshot(doc: device);
    });
  }

  static Stream<List<DeviceModel>> streamDevices(
      String restaurantId, String gropuId) {
    return _fireStoreGrupoCollection
        .doc(restaurantId)
        .collection('items')
        .doc(gropuId)
        .collection('devices')
        .snapshots()
        .map((devices) {
      final List<DeviceModel> list = [];
      for (final DocumentSnapshot<Map<String, dynamic>> doc in devices.docs) {
        list.add(DeviceModel.fromDocumentSnapshot(doc: doc));
      }
      return list;
    });
  }

  static Future<void> addDevice(
      String restaurantId, String gropuId, String name, String deviceId) async {
    await _fireStoreGrupoCollection
        .doc(restaurantId)
        .collection('items')
        .doc(gropuId)
        .collection('devices')
        .doc()
        .set({
      'name': name,
      'deviceId': deviceId,
    });

    await _fireStoreDeviceCollection.doc(deviceId).set({
      'restaurantId': restaurantId,
      'grupoId': gropuId,
    });
  }

  static void deleteDevice(
      String restaurantId, String gropuId, String deviceId) {
    _fireStoreGrupoCollection
        .doc(restaurantId)
        .collection('items')
        .doc(gropuId)
        .collection('devices')
        .doc(deviceId)
        .delete();

    _fireStoreDeviceCollection.doc(deviceId).delete();
  }
}
