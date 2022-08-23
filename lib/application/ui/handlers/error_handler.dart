import 'package:flutter/material.dart';

class SimpleErrorHandler {
  final BuildContext context;

  SimpleErrorHandler({required this.context});

  void handleError(Object e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.toString(),
        ),
      ),
    );
  }
}
