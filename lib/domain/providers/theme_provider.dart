import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeProvider {
  static ThemeData lightTheme = ThemeData(
    unselectedWidgetColor: AppColors.importantLight,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
      ),
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.deepPurple,
        onPrimary: Colors.deepOrange,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    unselectedWidgetColor: AppColors.importantDark,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
  );
}

abstract class AppColors {
  /// Общие  Colors

  /// Light colors
  static const importantLight = Colors.deepOrange;

  /// Dark Colors
  static const importantDark = Colors.red;
}
