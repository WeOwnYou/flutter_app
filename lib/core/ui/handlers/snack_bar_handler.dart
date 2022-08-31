import 'package:flutter/material.dart';
import 'package:flutter_app/core/ui/handlers/error_handler.dart';

class SnackBarErrorHandler implements ErrorHandler{
  final BuildContext context;

  SnackBarErrorHandler(this.context);

  @override
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
