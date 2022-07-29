import 'package:flutter/material.dart';
import 'package:flutter_app/intro_screen/intro_view_model.dart';
import 'package:provider/provider.dart';

class IntroView extends StatelessWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isGameStarted =
        context.select((IntroViewModel vm) => vm.isGameStarted);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(color: Colors.pinkAccent),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                width: isGameStarted ? 500 : 200,
                duration: const Duration(seconds: 2),
                onEnd: context.read<IntroViewModel>().startGame,
                child: FittedBox(
                  child: AnimatedOpacity(
                    opacity: isGameStarted ? 0.25 : 1,
                    duration: const Duration(seconds: 1),
                    child: Column(
                      children: [
                        Transform.scale(scale: 1.25, child: const Text('Game')),
                        const Icon(Icons.add),
                      ],
                    ),
                  ),
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
      ),
    );
  }
}
