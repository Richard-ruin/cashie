import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cashie/themes/colorscheme/DefaultColorScheme.dart';
import 'package:cashie/themes/colorscheme/GreenAppleColorScheme.dart';

class ThemeProvider with ChangeNotifier {
  static const String themeBoxName = 'themeBox';
  static const String themeModeKey = 'themeMode';
  static const String colorSchemeKey = 'colorScheme';

  ThemeMode _themeMode;
  ColorScheme _colorScheme;

  ThemeProvider()
      : _themeMode = _getSavedThemeMode() ?? ThemeMode.system,
        _colorScheme = _getSavedColorScheme() ?? ColorScheme.light();

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  ColorScheme get colorScheme => _colorScheme;

  static ThemeMode? _getSavedThemeMode() {
    final box = Hive.box(themeBoxName);
    final savedThemeMode = box.get(themeModeKey);
    if (savedThemeMode == ThemeMode.light.index) {
      return ThemeMode.light;
    } else if (savedThemeMode == ThemeMode.dark.index) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  static ColorScheme? _getSavedColorScheme() {
    final box = Hive.box(themeBoxName);
    final savedColorScheme = box.get(colorSchemeKey);
    if (savedColorScheme == 'default') {
      return ColorScheme.light();
    } else if (savedColorScheme == 'greenApple') {
      return ColorScheme.dark(
        primary: GreenColorScheme.primary,
        onPrimary: GreenColorScheme.onPrimary,
        // ...
      );
    } else {
      return null;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final box = Hive.box(themeBoxName);
    _themeMode = mode;
    await box.put(themeModeKey, mode.index);
    notifyListeners();
  }

  Future<void> setColorScheme(ColorScheme scheme) async {
    final box = Hive.box(themeBoxName);
    _colorScheme = scheme;
    await box.put(colorSchemeKey,
        scheme == ColorScheme.light() ? 'default' : 'greenApple');
    notifyListeners();
  }
}
