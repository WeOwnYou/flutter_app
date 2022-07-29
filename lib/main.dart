import 'package:flutter/material.dart';
import 'package:flutter_app/intro_screen/intro_view.dart';
import 'package:flutter_app/intro_screen/intro_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(),
        home: ChangeNotifierProvider(
          create: (context) => IntroViewModel(context),
          child: const IntroView(),
        ));
  }
}
