import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/navigation/main_navigation.dart';
import 'package:flutter_app/core/ui/handlers/error_handler.dart';
import 'package:flutter_app/core/ui/view_model/view_model.dart';

@immutable
class AuthModel {
  final String login;
  final String password;
  final bool isLoading;

  const AuthModel({
    this.login = '',
    this.password = '',
    this.isLoading = false,
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
  }) {
    return AuthModel(
      login: login ?? this.login,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AuthViewModel extends ViewModel {
  final BuildContext context;
  final SimpleErrorHandler errorHandler;
  AuthModel _authModel = const AuthModel();
  AuthModel get authModel => _authModel;

  AuthViewModel(this.context, this.errorHandler)
      : super(context, errorHandler: errorHandler);

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
    } on FirebaseAuthException catch (e) {
      handleError(e);
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
      _authModel = _authModel.copyWith(isLoading: false);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      handleError(e);
      _authModel = _authModel.copyWith(
        isLoading: false,
      );
      notifyListeners();
    }
  }

  void changeAuthData(String input, bool isLogin) {
    _authModel = isLogin
        ? _authModel.copyWith(login: input)
        : _authModel.copyWith(password: input);
  }
}
