import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF424242),
  scaffoldBackgroundColor: Color(0xFF121212),
  iconTheme: IconThemeData(color: Color(0xFFE4E6EB)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF2B2B2B),
    selectedItemColor: Color(0xFF424242),
    unselectedItemColor: Color(0xFFE4E6EB),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Color(0xFFFFFFFF)),
  ),
);
