import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/language_controller.dart';
import '../controllers/theme_controller.dart';
import '../models/menu_option_model.dart';
import '../utils/globals.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings.title'.tr),
      ),
      body: ListView(
        children: [
          languageListTile(context),
          themeListTile(context),
          ListTile(
            title: Text('settings.signOut'.tr),
            trailing: ElevatedButton(
              onPressed: () {
                AuthController.to.signOut();
              },
              child: Text(
                'settings.signOut'.tr,
              ),
            ),
          )
        ],
      ),
    );
  }

  languageListTile(BuildContext context) {
    return GetBuilder<LanguageController>(
      builder: (controller) => ListTile(
        title: Text('settings.language'.tr),
        trailing: DropdownButton<String>(
          items: Globals.languageOptions
              .map((data) => DropdownMenuItem<String>(
                    value: data.key,
                    child: Text(
                      data.value,
                    ),
                  ))
              .toList(),
          value: controller.currentLanguage,
          onChanged: (value) async {
            await controller.updateLanguage(value!);
            Get.forceAppUpdate();
          },
        ),
      ),
    );
  }

  themeListTile(BuildContext context) {
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: "system", value: 'settings.system'.tr, icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light", value: 'settings.light'.tr, icon: Icons.brightness_low),
      MenuOptionsModel(
          key: "dark", value: 'settings.dark'.tr, icon: Icons.brightness_3)
    ];
    return GetBuilder<ThemeController>(
      builder: (controller) => ListTile(
        title: Text('settings.theme'.tr),
        trailing: CupertinoSlidingSegmentedControl<String>(
          groupValue: controller.currentTheme,
          children: {
            for (var option in themeOptions)
              option.key: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(option.icon),
                  const SizedBox(width: 6),
                  Text(option.value),
                ],
              )
          },
          onValueChanged: (value) {
            controller.setThemeMode(value!);
          },
        ),
      ),
    );
  }
}
