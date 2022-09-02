import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/configuration/firebase_options.dart';
import 'package:flutter_app/my_app.dart';
import 'package:flutter_app/my_app_vm.dart';
import 'package:provider/provider.dart';





Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,) async {
  if(kDebugMode) {
    print(message.notification?.title);
  }
}

void main() async {
  await runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;

      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //   print('Got a message whilst in the foreground!');
      //   print('Message data: ${message.data}');
      //
      //   if (message.notification != null) {
      //     print('Message also contained a notification: ${message.notification}');
      //   }
      // });

      runApp(ChangeNotifierProvider(
        create: MyAppVm.new,
        child: const MyApp(),
      ),);
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}
