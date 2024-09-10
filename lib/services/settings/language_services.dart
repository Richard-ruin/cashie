import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier {
  Locale _locale = const Locale('id');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = const Locale('id');
    notifyListeners();
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<MaterialApp> {
  @override
  bool isSupported(Locale locale) => ['en', 'id'].contains(locale.languageCode);

  @override
  Future<MaterialApp> load(Locale locale) async {
    return MaterialApp(
      locale: locale,
    );
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<MaterialApp> old) => false;
}
