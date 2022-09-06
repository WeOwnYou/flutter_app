import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/ui/handlers/error_handler.dart';

class ViewModel extends ChangeNotifier {
  final ErrorHandler _errorHandler;

  ViewModel({
    required ErrorHandler errorHandler,
  }) : _errorHandler = errorHandler {
    onInit();
  }

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
      handleError(e);
    }
  }

  void handleError(Object e) {
    _errorHandler.handleError(e);
  }
}
