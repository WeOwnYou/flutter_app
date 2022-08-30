import 'package:flutter/material.dart';

class SimpleErrorHandler {
  final BuildContext context;

  SimpleErrorHandler({required this.context});

  void handleError(Object e) {
    // final isFirebaseAuthException =
    //     e.runtimeType == FirebaseAuthException(code: '').runtimeType;
    // late final Object errorMessage;
    // if (isFirebaseAuthException) {
    //   errorMessage = _getFirebaseAuthErrorMessage(
    //     (e as FirebaseAuthException).message,);
    // } else {
    //   errorMessage = e;
    // }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.toString(),
        ),
      ),
    );
  }
}
