import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LanguageProvider extends ChangeNotifier {
  static const String languageBoxName = 'languageBox';
  static const String languageKey = 'language';

  Locale _currentLocale;

  LanguageProvider() : _currentLocale = _getSavedLocale() ?? Locale('en');

  Locale get currentLocale => _currentLocale;

  static Locale? _getSavedLocale() {
    final box = Hive.box(languageBoxName);
    final savedLanguage = box.get(languageKey);
    if (savedLanguage != null) {
      return Locale(savedLanguage);
    } else {
      return null;
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    final box = Hive.box(languageBoxName);
    _currentLocale = Locale(languageCode);
    await box.put(languageKey, languageCode);
    notifyListeners();
  }
}
