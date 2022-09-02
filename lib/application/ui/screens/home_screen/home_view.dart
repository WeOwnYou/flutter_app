import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_events.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_state.dart';
import 'package:flutter_app/application/ui/screens/home_screen/home_view_model.dart';
import 'package:flutter_app/core/ui/handlers/print_handler.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget implements AutoRouteWrapper {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final onLogOutPressed = context.read<HomeViewModel>().logOut;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '< False or True >',
          style:
              TextStyle(color: Theme.of(context).textTheme.titleLarge?.color),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: ElevatedButton(
              onPressed: onLogOutPressed,
              child: const Text('log out'),
            ),
          ),
        ],
      ),
      body: StreamBuilder<HomeState>(
        initialData:
            Provider.of<HomeViewModel>(context, listen: false).initialState,
        stream: Provider.of<HomeViewModel>(context, listen: false).stream,
        builder: (ctx, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              var start = snapshot.requireData.questions!.length - 2;
              if (start < 0) start = 0;
              if (snapshot.requireData.complete) {
                return const _BuildRestartButton();
              }
              return Stack(
                children: snapshot.requireData.questions != null &&
                        snapshot.requireData.questions!.isNotEmpty
                    ? snapshot.requireData.questions!
                        .sublist(start)
                        .map((question) {
                        snapshot.requireData.questions!.length;
                        if (question == snapshot.requireData.questions!.last) {
                          return buildFrontCard(context, question);
                        } else {
                          return buildCard(question, ctx, false);
                        }
                      }).toList()
                    : [const _BuildRestartButton()],
              );
          }
        },
      ),
    );
  }

  Widget buildFrontCard(BuildContext context, Question question) {
    return GestureDetector(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final provider = Provider.of<HomeViewModel>(context);
          var milliseconds = provider.isDragging ? 0 : 400;
          final position = provider.position;
          if (position == Offset.zero) milliseconds = 0;
          final center = constraints.smallest.center(Offset.zero);
          final angle = provider.angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);
          return AnimatedContainer(
            duration: Duration(milliseconds: milliseconds),
            transform: rotatedMatrix..translate(position.dx, position.dy),
            child: buildCard(question, context, true),
          );
        },
      ),
      onPanStart: context.read<HomeViewModel>().startPosition,
      onPanUpdate: context.read<HomeViewModel>().updatePosition,
      onPanEnd: (details) {
        Provider.of<HomeViewModel>(context, listen: false)
            .add(SwitchCardEvent());
      },
    );
  }

  Widget buildCard(Question question, BuildContext context, bool isFront) {
    final isGoingTrue =
        context.select<HomeViewModel, bool?>((vm) => vm.isGoingTrue);
    final upperText = upperTextWidget(isGoingTrue, isFront);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              decoration: question.url == null
                  ? const BoxDecoration(
                      color: Colors.blueGrey,
                    )
                  : BoxDecoration(
                      color: Colors.blueGrey,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          question.url!,
                        ),
                      ),
                    ),
              child: Center(
                child: ColoredBox(
                  color: Colors.white,
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
        upperText ?? const SizedBox.shrink(),
      ],
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => HomeViewModel(
        ctx,
        const PrintErrorHandler(),
      ),
      child: this,
    );
  }
}

Widget? upperTextWidget(bool? isGoingTrue, bool isFront) {
  if ((isGoingTrue ?? false) && isFront) {
    return const Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 50.0, top: 25),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(-20 / 360),
          child: Text(
            'True',
            style: TextStyle(
              color: Colors.green,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  if (isGoingTrue == false && isFront) {
    return const Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(right: 50, top: 25),
        child: RotationTransition(
          turns: AlwaysStoppedAnimation(20 / 360),
          child: Text(
            'False',
            style: TextStyle(
              color: Colors.red,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
  return null;
}

class _BuildRestartButton extends StatelessWidget {
  const _BuildRestartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Provider.of<HomeViewModel>(context, listen: false)
              .add(InitializeEvent()),
          child: const Text('Reset'),
        ),
      ),
    );
  }
}
