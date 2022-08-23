import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SimpleErrorHandler {
  final BuildContext context;

  SimpleErrorHandler({required this.context});

  void handleError(Object e) {
    final isFirebaseAuthException =
        e.runtimeType == FirebaseAuthException(code: '').runtimeType;
    late final Object errorMessage;
    if (isFirebaseAuthException) {
      errorMessage = _getFirebaseAuthErrorMessage(
        (e as FirebaseAuthException).message,);
    } else {
      errorMessage = e;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage.toString(),
        ),
      ),
    );
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
      default:
        return 'Ошибка';
    }
  }
}
