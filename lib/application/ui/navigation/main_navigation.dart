import 'package:flutter/material.dart';
import 'package:flutter_app/core/domain/factories/screen_factory.dart';

abstract class Routes {
  static const authScreen = 'auth';
  static const introScreen = '/';
  static const homeScreen = '/home_screen';
  static const loosingScreen = '/loosing_screen';
}

class MainNavigation {
  final _screenFactory = ScreenFactory();

  Route<Widget> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.authScreen:
        return PageRouteBuilder<Widget>(
          pageBuilder: (_, __, ___) => _screenFactory.makeAuthScreen(),
        );
      case Routes.introScreen:
        return PageRouteBuilder<Widget>(
          pageBuilder: (_, __, ___) => _screenFactory.makeIntroScreen(),
        );
      case Routes.homeScreen:
        return PageRouteBuilder<Widget>(
          pageBuilder: (_, __, ___) => _screenFactory.makeHomeScreen(),
        );
      case Routes.loosingScreen:
        return PageRouteBuilder<Widget>(
          pageBuilder: (_, __, ___) => _screenFactory.makeLoosingScreen(),
        );
      default:
        return PageRouteBuilder<Widget>(
          pageBuilder: (_, __, ___) => _screenFactory.makeIntroScreen(),
        );
    }
  }
}
