import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/intro_screen/intro_view.dart';
import 'package:flutter_app/intro_screen/intro_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      home: ChangeNotifierProvider(
        create: IntroViewModel.new,
        child: const IntroView(),
      ),
    );
  }
}

abstract class ThemeProvider {
  static ThemeData lightTheme = ThemeData(
    unselectedWidgetColor: AppColors.importantLight,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        )
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      primary: Colors.deepPurple,
      onPrimary: Colors.deepOrange,
    ),),
  );

  static ThemeData darkTheme = ThemeData(
    unselectedWidgetColor: AppColors.importantDark,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        )
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