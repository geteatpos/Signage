import 'package:device_info_plus/device_info_plus.dart';

import '../models/menu_option_model.dart';
import 'dart:io' show Platform;

class Globals {
  static const String defaultLanguage = 'en';
  static const dummy = "c3cbe44a-5d2e-47ce-9097-74a7121022a2";

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "en", value: "English"), //English
    MenuOptionsModel(key: "es", value: "Español"), //Spanish
  ];

  static Future<bool> isTV() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.systemFeatures
          .contains('android.software.leanback');
    }

    return false;
  }

  static const noImage =
      "https://firebasestorage.googleapis.com/v0/b/geteatpos-4e3af.appspot.com/o/no-image-found.png?alt=media&token=2a7c91be-21f9-41f7-9f7c-23159878f09f";
}
