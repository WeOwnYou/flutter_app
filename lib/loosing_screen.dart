import 'package:flutter/material.dart';
import 'package:flutter_app/intro_screen/intro_view.dart';
import 'package:flutter_app/intro_screen/intro_view_model.dart';
import 'package:provider/provider.dart';

class LoosingScreen extends StatefulWidget {
  const LoosingScreen({Key? key}) : super(key: key);

  @override
  State<LoosingScreen> createState() => _LoosingScreenState();
}

class _LoosingScreenState extends State<LoosingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _BuildLoosAnimatedIcon(),
                _BuildLoosAnimatedIcon(),
              ],
            ),
            const _BuildLoosAnimatedIcon(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                _BuildLoosAnimatedIcon(),
                _BuildLoosAnimatedIcon(),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: (){startAgain(context);},
          child: const Center(
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(-45 / 360),
                child: Text(
            'Start Again',
            style: TextStyle(
                  fontSize: 40, color: Colors.red, fontWeight: FontWeight.bold),
          ),
              )),
        ),
      ]),
    );
  }
  startAgain(BuildContext context){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (BuildContext context) => IntroViewModel(context),
              child:  const IntroView(),
            )),
            (route) => false);
  }
}

class _BuildLoosAnimatedIcon extends StatefulWidget {
  const _BuildLoosAnimatedIcon({Key? key}) : super(key: key);

  @override
  State<_BuildLoosAnimatedIcon> createState() => _BuildLoosAnimatedIconState();
}

class _BuildLoosAnimatedIconState extends State<_BuildLoosAnimatedIcon> {
  int size = 0;
  static const maxSize = 100;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        size = maxSize;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: size.toDouble(),
      duration: const Duration(milliseconds: 1000),
      child: const FittedBox(child: Icon(Icons.new_releases_outlined)),
      onEnd: () {
        setState(() {
          size = (size == maxSize ? 0 : maxSize);
        });
      },
    );
  }
}
