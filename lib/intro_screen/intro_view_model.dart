import 'package:flutter/material.dart';
import 'package:flutter_app/home_screen/home_view.dart';
import 'package:flutter_app/home_screen/home_view_model.dart';
import 'package:provider/provider.dart';

class IntroViewModel extends ChangeNotifier {
  final BuildContext _context;
  bool isGameStarted = false;
  IntroViewModel(this._context);

  void onPlayTapped() {
    isGameStarted = !isGameStarted;
    notifyListeners();
  }

  void startGame() {
    Navigator.pushAndRemoveUntil<ChangeNotifierProvider>(
      _context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ChangeNotifierProvider(
          create: HomeViewModel.new,
          child: const HomeView(),
        ),
      ),
      (route) => false,
    );
  }
}
