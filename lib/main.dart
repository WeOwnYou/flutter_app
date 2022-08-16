import 'package:flutter/material.dart';
import 'package:flutter_app/core/navigation/main_navigation.dart';
import 'package:flutter_app/domain/providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainNavigation = MainNavigation();
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeProvider.lightTheme,
      darkTheme: ThemeProvider.darkTheme,
      initialRoute: Routes.introScreen,
      onGenerateRoute: mainNavigation.onGenerateRoute,
    );
  }
}
