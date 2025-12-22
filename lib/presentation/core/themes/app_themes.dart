import 'package:flutter/material.dart';

import '../colors/app_palette.dart';

class AppTheme {
  // Light Theme
  static final lightTheme = ThemeData(
    fontFamily: 'Outfit',
    primaryColor: AppPalette.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppPalette.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPalette.white,
      selectedItemColor: AppPalette.black,
      unselectedItemColor: AppPalette.grey,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.blue,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    cardColor: AppPalette.blue.withValues(alpha: 0.2),
  );

  // Dark Theme
  static final darkTheme = ThemeData(
    fontFamily: 'Outfit',
    primaryColor: AppPalette.blue,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppPalette.black,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPalette.black,
      selectedItemColor: AppPalette.white,
      unselectedItemColor: AppPalette.grey,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.blue,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardColor: AppPalette.blue.withValues(alpha: 0.2),
  );
}
