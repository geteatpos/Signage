import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'controllers/auth_controller.dart';
import 'controllers/language_controller.dart';
import 'controllers/theme_controller.dart';
import 'utils/app_routes.dart';
import 'utils/app_themes.dart';
import 'utils/localization.g.dart';
import 'widgets/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBTujTEITmnPR5q1dVLhL7kbTlvgwf-DHY",
        authDomain: "geteatpos-4e3af.firebaseapp.com",
        databaseURL: "https://geteatpos-4e3af-default-rtdb.firebaseio.com",
        projectId: "geteatpos-4e3af",
        storageBucket: "geteatpos-4e3af.appspot.com",
        messagingSenderId: "41462628241",
        appId: "1:41462628241:web:098a664d76f1ba44d36430",
      ),
    );
  }

  await GetStorage.init();

  String? deviceId = await PlatformDeviceId.getDeviceId;
  await GetStorage().write('deviceId', deviceId);

  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
      builder: (languageController) => Loading(
        child: GetMaterialApp(
          translations: Localization(),
          locale: languageController.getLocale,
          debugShowCheckedModeBanner: false,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: ThemeMode.system,
          initialRoute: "/",
          getPages: AppRoutes.routes,
        ),
      ),
    );
  }
}
