import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/navigation/main_navigation.dart';
import 'package:flutter_app/firebase_options.dart';

class AuthViewModel extends ChangeNotifier {
  final BuildContext context;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorText = '';
  bool _isLoading = false;

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  String get errorText => _errorText;
  bool get isLoading => _isLoading;

  AuthViewModel(this.context) {
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
      final navigator = Navigator.of(context);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        // TODO(fake): change fake data
        email: '123@123.com', //_emailController.text,
        password: '123456', //_passwordController.text,
      );
      unawaited(
        navigator.pushReplacementNamed(
          Routes.homeScreen,
        ),
      );
    } on FirebaseAuthException catch (e) {
      _errorText = getErrorMessage(e.message);
      _isLoading = false;
      notifyListeners();
    }
  }

  String getErrorMessage(String? error) {
    switch (error) {
      case 'The email address is badly formatted.':
        return 'Неправильный формат email';
      case 'Given String is empty or null.':
        return 'Заполните оба поля';
      case 'The password is invalid or the user does not have a password.':
        return 'Неверные логин или пароль';
      case 'Password should be at least 6 characters':
        return 'Пароль должен содержать 6 и болле символов';
      case 'There is no user record corresponding to this identifier. The user may have been deleted.':
        return 'Неверные логин или пароль';
      default:
        return 'Ошибка';
    }
  }
}
