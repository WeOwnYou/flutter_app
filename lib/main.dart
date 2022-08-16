import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/navigation/main_navigation.dart';
import 'package:flutter_app/domain/providers/theme_provider.dart';
import 'package:flutter_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
