import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeModeProvider with ChangeNotifier {
  static const String themeModeBoxName = 'themeModeBox';
  static const String themeModeKey = 'themeMode';

  ThemeMode _themeMode;

  ThemeModeProvider() : _themeMode = _getSavedThemeMode() ?? ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  static ThemeMode? _getSavedThemeMode() {
    final box = Hive.box(themeModeBoxName);
    final savedThemeMode = box.get(themeModeKey);
    if (savedThemeMode == ThemeMode.light.index) {
      return ThemeMode.light;
    } else if (savedThemeMode == ThemeMode.dark.index) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    final box = Hive.box(themeModeBoxName);
    _themeMode = themeMode;
    await box.put(themeModeKey, themeMode.index);
    notifyListeners();
  }
}
