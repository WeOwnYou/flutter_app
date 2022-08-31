import 'package:flutter/foundation.dart';
import 'package:flutter_app/core/ui/handlers/error_handler.dart';

class PrintErrorHandler implements ErrorHandler{
  const PrintErrorHandler();

  @override
  void handleError(Object e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
