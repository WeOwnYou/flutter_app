import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/auth_screen/auth_view.dart';
import 'package:flutter_app/auth_screen/auth_view_model.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/home_screen/home_view.dart';
import 'package:flutter_app/home_screen/home_view_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

class IntroViewModel extends ChangeNotifier {
  final BuildContext _context;
  bool isGameStarted = false;
  IntroViewModel(this._context);

  void onPlayTapped() {
    isGameStarted = !isGameStarted;
    notifyListeners();
  }

  Future<void> startGame() async{
    isGameStarted = true;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final email = await secureStorage.read(key: 'email');
    final password = await secureStorage.read(key: 'password');
    if(email != null && password != null){
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        _navigateToGame();
      }on Exception {
        _navigateToAuth();
      }
    }
    else{
      _navigateToAuth();
    }
  }

  void _navigateToGame(){
    Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: HomeViewModel.new,
              child: const HomeView(),
            )),
            (route) => false);
  }
  void _navigateToAuth(){
    Navigator.pushAndRemoveUntil(
        _context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: AuthViewModel.new,
              child: const AuthView(),
            )),
            (route) => false);
  }
}
