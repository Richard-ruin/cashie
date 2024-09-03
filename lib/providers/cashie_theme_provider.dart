import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CashieThemeController extends ChangeNotifier {
  static const String _themeBox = 'themeBox';
  static const String _themeKey = 'themeKey';

  late String _appTheme;

  String get appTheme => _appTheme;

  CashieThemeController() {
    _appTheme = _loadThemeFromHive() ?? 'DefaultColorScheme';
  }

  String? _loadThemeFromHive() {
    final box = Hive.box(_themeBox);
    return box.get(_themeKey);
  }

  Future<void> _saveThemeToHive(String theme) async {
    final box = Hive.box(_themeBox);
    await box.put(_themeKey, theme);
  }

  void updateTheme(String theme) {
    _appTheme = theme;
    _saveThemeToHive(theme);
    notifyListeners();
  }
}

class CashieTheme {
  static ThemeData getTheme(String themeName) {
    switch (themeName) {
      case 'GreenAppleColorScheme':
        return GreenAppleColorScheme();
      default:
        return DefaultColorScheme();
    }
  }
}

ThemeData DefaultColorScheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.blue),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blue,
    ),
  );
}

ThemeData GreenAppleColorScheme() {
  return ThemeData(
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.green),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green,
    ),
  );
}
