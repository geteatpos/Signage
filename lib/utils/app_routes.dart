import 'package:get/get.dart';

import '../screens/home_screen.dart';
import '../screens/reset_password_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/signin_screen.dart';
import '../screens/splash_screen.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/signin', page: () => SigninScreen()),
    GetPage(name: '/home', page: () => const HomeScreen()),
    GetPage(name: '/settings', page: () => const SettingsScreen()),
    GetPage(name: '/reset-password', page: () => ResetPasswordScreen()),
  ];
}
