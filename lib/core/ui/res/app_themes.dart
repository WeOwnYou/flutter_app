import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/core/ui/res/res.dart';

abstract class AppThemes{
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
        // TODO(deprecated): fix this
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
