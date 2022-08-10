import 'package:flutter/material.dart';
import 'package:flutter_app/intro_screen/intro_view_model.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final isGameStarted =
    context.select((IntroViewModel vm) => vm.isGameStarted);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_controller.status == AnimationStatus.completed) {
            _controller.reverse();
          } else {
            _controller.forward().then((value) {
              Provider.of<IntroViewModel>(context, listen: false).startGame();
            });
          }
        },
        child: const Icon(Icons.play_arrow_sharp),
      ),
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
            Visibility(
              visible: isGameStarted ? false : true,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: context.read<IntroViewModel>().onPlayTapped,
                child: const Text(
                  'Play',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.purpleAccent,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
