import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/navigation/main_navigation.dart';
import 'package:flutter_app/core/ui/overlay/connectivity_overlay.dart';
import 'package:flutter_app/core/ui/res/app_themes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    await _onConnectivityChanged(await Connectivity().checkConnectivity());
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);
  }

  Future<void> _onConnectivityChanged(ConnectivityResult? e) async {
    // print('a');
    if (e == ConnectivityResult.none) {
      ConnectivityOverlay.instance.showOverlay(context, 'No internet');
      // print(ConnectivityOverlay.instance.overlayEntry);
    } else {
      ConnectivityOverlay.instance.removeOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.light,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
}
