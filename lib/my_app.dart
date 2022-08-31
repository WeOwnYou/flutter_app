import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/navigation/main_navigation.dart';
import 'package:flutter_app/core/ui/res/app_themes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      initialRoute: Routes.introScreen,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
