import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cashie/themes/colorscheme/DefaultColorScheme.dart';
import 'package:cashie/themes/colorscheme/GreenAppleColorScheme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ColorScheme _colorScheme = ColorScheme.light();

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  ColorScheme get colorScheme => _colorScheme;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _updateColorScheme();
    notifyListeners();
  }

  void toggleDarkMode() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _updateColorScheme();
    notifyListeners();
  }

  void setColorScheme(ColorScheme scheme) {
    _colorScheme = scheme;
    notifyListeners();
  }

  void _updateColorScheme() {
    if (isDarkMode) {
      _colorScheme = ColorScheme.dark(
        primary: GreenColorScheme.primary,
        onPrimary: GreenColorScheme.onPrimary,
        // ...
      );
    } else {
      _colorScheme = ColorScheme.light(
        primary: DefaultColorScheme.primary,
        onPrimary: DefaultColorScheme.onPrimary,
        // ...
      );
    }
  }
}
