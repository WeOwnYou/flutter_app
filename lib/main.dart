import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/navigation/main_navigation.dart';
import 'package:flutter_app/domain/providers/theme_provider.dart';
import 'package:flutter_app/firebase_options.dart';

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      runApp(const MyApp());
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
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
