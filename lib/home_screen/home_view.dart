import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/home_screen/home_view_model.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onLogOutPressed = context.read<HomeViewModel>().signOut;
    return Scaffold(
        appBar: AppBar(
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
                  onPressed: onLogOutPressed, child: const Text('log out')),
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
                if (snapshot.requireData.complete) {
                  return ElevatedButton(
                      onPressed: () {}, child: const Text('Reset'));
                }
                return Stack(
                  children: snapshot.requireData.questions != null &&
                          snapshot.requireData.questions!.isNotEmpty
                      ? snapshot.requireData.questions!.map((question) {
                          if (question ==
                              snapshot.requireData.questions!.last) {
                            return buildFrontCard(context, question);
                          } else {
                            return buildCard(context, question);
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
          final provider = Provider.of<HomeViewModel>(context, listen: true);
          final milliseconds = provider.isDragging ? 0 : 400;
          final position = provider.position;
          final center = constraints.smallest.center(Offset.zero);
          final angle = provider.angle * pi / 180;
          final rotatedMatrix = Matrix4.identity()
            ..translate(center.dx, center.dy)
            ..rotateZ(angle)
            ..translate(-center.dx, -center.dy);
          return AnimatedContainer(
            duration: Duration(milliseconds: milliseconds),
            transform: rotatedMatrix..translate(position.dx, position.dy),
            child: buildCard(
              context,
              question,
            ),
          );
        },
      ),
      onPanStart: (details) {
        context.read<HomeViewModel>().startPosition(details);
      },
      onPanUpdate: (details) {
        context.read<HomeViewModel>().updatePosition(details);
      },
      onPanEnd: (details) {
        context.read<HomeViewModel>().endPosition();
      },
    );
  }

  Widget buildCard(BuildContext context, Question question) {
    Widget? upperText;
    return Padding(
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
          child: Column(
            children: [
              upperText ?? const SizedBox.shrink(),
              Expanded(
                child: Center(
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
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

class _BuildRestartButton extends StatelessWidget {
  const _BuildRestartButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: context.read<HomeViewModel>().resetImages,
          child: const Text('Reset'),
        ),
      ),
    );
  }
}
