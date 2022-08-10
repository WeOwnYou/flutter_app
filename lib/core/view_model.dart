import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ViewModel extends ChangeNotifier {
  BuildContext context;
  ViewModel(this.context) {
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
      FutureOr<void> Function() call, {void Function()? onError,}) async {
    try {
      await call();
    } on Exception catch (e) {
      onError?.call();
      if (e is DioError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.error}')));
      }
    }
  }
}

// FutureOr<void> safe(
//     FutureOr<void> Function() call, {
//       String Function(Object)? onError,
//     }) async {
//   try {
//     await call();
//   } on Object catch (e) {
//     final message = onError?.call(e) ?? 'Непредвиденная ошибка!';
//     handleError(message);
//   }
// }
