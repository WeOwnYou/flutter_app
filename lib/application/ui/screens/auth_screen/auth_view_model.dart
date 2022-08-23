import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/navigation/main_navigation.dart';


//TODO(модель): подумать как расширить, чтобы не хранить миллиард полей
class AuthModel {
  String login;
  String password;

  AuthModel({
    this.login = '',
    this.password = '',
  });

  @override
  String toString() {
    return 'AuthModel{login: $login, password: $password}';
  }
}

class AuthViewModel extends ChangeNotifier {
  final BuildContext context;
  final AuthModel _authModel = AuthModel();
  String _errorText = '';
  bool _isLoading = false;
  String get errorText => _errorText;
  bool get isLoading => _isLoading;

  AuthViewModel(this.context);

  Future<void> registerAccount() async {
    _isLoading = true;
    _errorText = '';
    notifyListeners();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _authModel.login,
        password: _authModel.password,
      );
    } on FirebaseAuthException catch (e) {
      _errorText = _getErrorMessage(e.message);
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
        email: _authModel.login,
        password: _authModel.password,
      );
      unawaited(
        navigator.pushReplacementNamed(
          Routes.homeScreen,
        ),
      );
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _errorText = _getErrorMessage(e.message);
      _isLoading = false;
      notifyListeners();
    }
  }

  void changeAuthData(String input, bool isLogin) {
    isLogin ? _authModel.login = input : _authModel.password = input;
  }

  String _getErrorMessage(String? error) {
    switch (error) {
      case 'The email address is badly formatted.':
        return 'Неправильный формат email';
      case 'Given String is empty or null':
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