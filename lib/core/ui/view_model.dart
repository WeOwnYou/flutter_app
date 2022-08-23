import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/handlers/error_handler.dart';

class ViewModel extends ChangeNotifier {
  SimpleErrorHandler _errorHandler;

  ViewModel({
    required SimpleErrorHandler errorHandler,
  }) : _errorHandler = errorHandler;

  void onInit() {
    debugPrint('Initialize: hash: $hashCode, hasListeners: $hasListeners');
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('$this is disposed');
  }

  FutureOr<void> safe(
    FutureOr<void> Function() call, {
    void Function()? onError,
  }) async {
    try {
      await call();
    } on Exception catch (e) {
      onError?.call();
      if (e is DioError) {
        handleError(e);
      }
    }
  }

  void handleError(Object e) {
    _errorHandler.handleError(e);
  }
}
