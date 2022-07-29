import 'package:flutter/material.dart';
import 'package:flutter_app/home_screen/home_view.dart';
import 'package:flutter_app/home_screen/home_view_model.dart';
import 'package:provider/provider.dart';

class IntroViewModel extends ChangeNotifier {
  final BuildContext _context;
  bool isGameStarted = false;
  IntroViewModel(this._context);
  onPlayTapped() {
    isGameStarted = !isGameStarted;
    notifyListeners();
  }

  startGame() {
    Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (BuildContext context) => HomeViewModel(context),
                  child: const HomeView(),
                )),
        (route) => false);
  }
}
