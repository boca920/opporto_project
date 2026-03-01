import 'package:flutter/material.dart';

class AppLanguageProvider extends ChangeNotifier {
  Locale _appLocale = const Locale("en");

  Locale get appLocale => _appLocale;

  void changeLanguage(String languageCode) {
    _appLocale = Locale(languageCode);
    notifyListeners();
  }
}