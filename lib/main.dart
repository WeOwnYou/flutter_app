import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/configuration/firebase_options.dart';
import 'package:flutter_app/my_app.dart';
import 'package:flutter_app/my_app_vm.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

const channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.max,
);

Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  print(message.data);
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
      print(await FirebaseMessaging.instance.getToken());
      // await FirebaseMessaging.instance.requestPermission(announcement: true);
      await FirebaseMessaging.instance.subscribeToTopic('test');
      // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions();
      //\
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
      // print('${await FirebaseMessaging.instance.getToken()}!');
      // // print((await FirebaseMessaging.instance.getInitialMessage()));

      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      const initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
      );
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);

      FirebaseMessaging.onMessage.listen((message) {
        final notification = message.notification;
        final android = message.notification?.android;
        print(message.data);
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification?.title,
          notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: android?.smallIcon,
              // other properties...
            ),
          ),
        );
      });

      runApp(
        ChangeNotifierProvider(
          create: MyAppVm.new,
          child: const MyApp(),
        ),
      );
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}
