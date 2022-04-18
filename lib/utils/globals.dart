import '../models/menu_option_model.dart';

class Globals {
  static const String defaultLanguage = 'en';
  static const dummy = "c3cbe44a-5d2e-47ce-9097-74a7121022a2";

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "en", value: "English"), //English
    MenuOptionsModel(key: "es", value: "Español"), //Spanish
  ];
}
