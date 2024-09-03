import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'colorscheme/DefaultColorScheme.dart';
import 'colorscheme/GreenAppleColorScheme.dart';
// Import skema warna lainnya di sini

// Enum untuk tema aplikasi
enum AppTheme {
  DEFAULT,
  GREEN_APPLE,
  LAVENDER,
  MIDNIGHT_DUSK,
  NORD,
  STRAWBERRY_DAIQUIRI,
  TAKO,
  TEAL_TURQUOISE,
  TIDAL_WAVE,
  YINYANG,
  YOTSUBA,
  MONET,
}

// Controller untuk mengelola tema
class CashieThemeController extends ChangeNotifier {
  AppTheme _appTheme = AppTheme.DEFAULT;

  AppTheme get appTheme => _appTheme;

  void setTheme(AppTheme theme) {
    _appTheme = theme;
    notifyListeners();
  }
}

// Kelas untuk tema Cashie
@immutable
class CashieTheme {
  static ThemeData getTheme(AppTheme appTheme) {
    final brightness = SchedulerBinding.instance.window.platformBrightness;
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      colorScheme: _getThemeColorScheme(appTheme, isDark),
      brightness: isDark ? Brightness.dark : Brightness.light,
      // Tambahkan konfigurasi tema lainnya di sini jika diperlukan
    );
  }

  static ColorScheme _getThemeColorScheme(AppTheme appTheme, bool isDark) {
    final colorScheme = _colorSchemes[appTheme];
    return colorScheme?.getColorScheme(isDark) ??
        DefaultColorScheme().getColorScheme(isDark);
  }

  // Definisikan peta skema warna
  static final Map<AppTheme, BaseColorScheme> _colorSchemes = {
    AppTheme.DEFAULT: DefaultColorScheme(),
    AppTheme.GREEN_APPLE: GreenAppleColorScheme(),
    // Tambahkan skema warna lainnya di sini
  };
}

// Abstraksi skema warna
abstract class BaseColorScheme {
  ColorScheme getColorScheme(bool isDark);
}
