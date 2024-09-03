import 'package:flutter/material.dart';
import 'package:cashie/themes/cashie_theme.dart';

class DefaultColorScheme implements BaseColorScheme {
  @override
  ColorScheme getColorScheme(bool isDark) {
    return ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: isDark ? Colors.blueGrey[800]! : Colors.blue[700]!,
      onPrimary: Colors.white,
      secondary: isDark ? Colors.blueGrey[600]! : Colors.blue[300]!,
      onSecondary: Colors.white,
      error: Colors.red[400]!,
      onError: Colors.white,
      background: isDark ? Colors.grey[900]! : Colors.grey[100]!,
      onBackground: isDark ? Colors.white : Colors.black,
      surface: isDark ? Colors.grey[800]! : Colors.white,
      onSurface: isDark ? Colors.white : Colors.black,
    );
  }
}
