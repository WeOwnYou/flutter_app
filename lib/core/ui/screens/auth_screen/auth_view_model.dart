import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/ui/screens/home_screen/home_view.dart';
import 'package:flutter_app/core/ui/screens/home_screen/home_view_model.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:provider/provider.dart';

class AuthViewModel extends ChangeNotifier {
  final BuildContext _context;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorText = '';
  bool _isLoading = false;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  String get errorText => _errorText;
  bool get isLoading => _isLoading;

  AuthViewModel(this._context) {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<void> registerAccount() async {
    _isLoading = true;
    _errorText = '';
    notifyListeners();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message??'');
      _errorText = getErrorMessage(e.message);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword() async {
    _isLoading = true;
    _errorText = '';
    notifyListeners();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _navigateToHomeScreen();
    } on FirebaseAuthException catch (e) {
      _errorText = getErrorMessage(e.message);
    }
    _isLoading = false;
    notifyListeners();
  }

  String getErrorMessage(String? error) {
    debugPrint(error ?? '');
    switch (error) {
      case 'The email address is badly formatted.':
        return 'Неправильный формат email';
      case 'Given String is empty or null.':
        return 'Заполните оба поля';
      case 'The password is invalid or the user does not have a password.':
        return 'Неверные логин или пароль';

      default:
        return error ?? '';
    }
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacement(
      _context,
      MaterialPageRoute<HomeViewModel>(
        builder: (context) => ChangeNotifierProvider(
          create: HomeViewModel.new,
          child: const HomeView(),
        ),
      ),
    );
  }
}
