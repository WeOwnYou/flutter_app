import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/screens/auth_screen/auth_view.dart';
import 'package:flutter_app/application/ui/screens/auth_screen/auth_view_model.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_view.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_view_model.dart';
import 'package:flutter_app/application/ui/screens/intro_screen/intro_view.dart';
import 'package:flutter_app/application/ui/screens/loosing_screen/loosing_screen.dart';
import 'package:flutter_app/core/ui/handlers/error_handler.dart';
import 'package:provider/provider.dart';

class ScreenFactory {
  Widget makeAuthScreen() {
    return ChangeNotifierProvider(
      create: (ctx) => AuthViewModel(
        ctx,
        SimpleErrorHandler(context: ctx),
      ),
      child: const AuthView(),
    );
  }

  Widget makeIntroScreen() {
    return const IntroView();
  }

  Widget makeHomeScreen() {
    return ChangeNotifierProvider(
      create: (ctx) => HomeViewModel(
        ctx,
        SimpleErrorHandler(context: ctx),
      ),
      child: const HomeView(),
    );
  }

  Widget makeLoosingScreen() {
    return const LoosingScreen();
  }
}
