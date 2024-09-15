import 'package:flutter/material.dart';
import 'package:cashie/themes/colorscheme/DefaultColorScheme.dart';
import 'package:cashie/themes/colorscheme/GreenAppleColorScheme.dart';

class ThemeController extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ColorScheme _colorScheme = const ColorScheme.light();

  ThemeMode get themeMode => _themeMode;
  ColorScheme get colorScheme => _colorScheme;

  void toggleThemeMode() {
    if (_themeMode == ThemeMode.light) {
      _themeMode = ThemeMode.dark;
      _colorScheme = const ColorScheme.dark(
        primary: GreenColorScheme.primary,
        onPrimary: GreenColorScheme.onPrimary,
        // ...
      );
    } else {
      _themeMode = ThemeMode.light;
      _colorScheme = const ColorScheme.light(
        primary: DefaultColorScheme.primary,
        onPrimary: DefaultColorScheme.onPrimary,
        // ...
      );
    }
    notifyListeners();
  }
}
