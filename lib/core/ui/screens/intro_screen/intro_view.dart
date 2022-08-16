import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/navigation/main_navigation.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  State<IntroView> createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView>
    with SingleTickerProviderStateMixin<IntroView> {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  late final _scale = Tween<double>(
    begin: 1,
    end: 5,
  ).animate(_controller);

  late final _opacity = Tween<double>(
    begin: 1,
    end: 0,
  ).animate(_controller);

  late final _buttonScale =
      Tween<double>(begin: 1, end: 0).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (ctx, child) => Opacity(
                opacity: _opacity.value,
                child: Transform.scale(
                  scale: _scale.value,
                  child: child,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Game',
                    style: TextStyle(
                      fontSize: 80,
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                  ),
                  const Icon(
                    Icons.add,
                    size: 40,
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (ctx, child) {
                return Opacity(
                  opacity: _opacity.value,
                  child: Transform.scale(
                    scale: _buttonScale.value,
                    child: child,
                  ),
                );
              },
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  _controller.forward().then((value) {
                    startGame(_controller);
                  });
                },
                child: const Text(
                  'Play',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.purpleAccent,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startGame(AnimationController controller) async {
    if (FirebaseAuth.instance.currentUser != null) {
      unawaited(_navigateToHomeScreen());
    } else {
      unawaited(_navigateToAuthScreen());
    }
  }

  Future<void> _navigateToHomeScreen() async {
    await Navigator.pushNamed(context, Routes.homeScreen);
  }

  Future<void> _navigateToAuthScreen() async {
    print((await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: '123@123.com',
      password: '123456',
    )).user?.email);
    await Navigator.pushReplacementNamed(context, Routes.authScreen);
  }
}
