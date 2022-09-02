import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/navigation/main_navigation.dart';
import 'package:flutter_app/core/ui/handlers/snack_bar_handler.dart';
import 'package:flutter_app/core/ui/view_model/view_model.dart';

@immutable
class AuthModel {
  final String login;
  final String password;
  final bool isLoading;
  final String errorText;

  const AuthModel({
    this.login = '',
    this.password = '',
    this.isLoading = false,
    this.errorText = '',
  });

  @override
  String toString() {
    return 'AuthModel{login: $login, password: $password}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthModel &&
          runtimeType == other.runtimeType &&
          login == other.login &&
          password == other.password &&
          isLoading == other.isLoading;

  @override
  int get hashCode => login.hashCode ^ password.hashCode ^ isLoading.hashCode;
  AuthModel copyWith({
    String? login,
    String? password,
    bool? isLoading,
    String? errorText,
  }) {
    return AuthModel(
      login: login ?? this.login,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      errorText: errorText ?? this.errorText,
    );
  }
}

class AuthViewModel extends ViewModel {
  final BuildContext context;
  final SnackBarErrorHandler errorHandler;
  AuthModel _authModel = const AuthModel();
  AuthModel get authModel => _authModel;

  AuthViewModel(this.context, this.errorHandler)
      : super(errorHandler: errorHandler);

  Future<void> registerAccount() async {
    _authModel = _authModel.copyWith(
      isLoading: true,
    );
    notifyListeners();
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _authModel.login,
        password: _authModel.password,
      );
      _authModel = _authModel.copyWith(errorText: '');
    } on FirebaseAuthException catch (e) {
      _authModel = _authModel.copyWith(
        errorText: _getFirebaseAuthErrorMessage(e.message),
      );
    }
    _authModel = _authModel.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword() async {
    _authModel = _authModel.copyWith(
      isLoading: true,
    );
    notifyListeners();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _authModel.login,
        password: _authModel.password,
      );
      unawaited(context.router.replaceNamed(Routes.mainScreen));
      _authModel = _authModel.copyWith(errorText: '');
    } on FirebaseAuthException catch (e) {
      _authModel = _authModel.copyWith(
        errorText: _getFirebaseAuthErrorMessage(e.message),
      );
    }
    _authModel = _authModel.copyWith(isLoading: false);
    notifyListeners();
  }

  String _getFirebaseAuthErrorMessage(String? error) {
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
      case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
        return 'Ошибка сети';
      default:
        return 'Ошибка';
    }
  }

  void changeAuthData(String input, bool isLogin) {
    _authModel = isLogin
        ? _authModel.copyWith(login: input)
        : _authModel.copyWith(password: input);
  }
}
