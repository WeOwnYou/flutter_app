import 'package:flutter/material.dart';

class BuildOverlayEntryWidget extends StatefulWidget {
  final String text;
  final int secondsDuration;
  const BuildOverlayEntryWidget(
      {required this.text, required this.secondsDuration, Key? key})
      : super(key: key);

  @override
  State<BuildOverlayEntryWidget> createState() =>
      BuildOverlayEntryWidgetState();
}

class BuildOverlayEntryWidgetState extends State<BuildOverlayEntryWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController? animationController;
  late final Animation<double>? animation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: widget.secondsDuration * 500));
    animation =
        CurveTween(curve: Curves.fastOutSlowIn).animate(animationController!);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animationController
          ?.forward()
          .then((value) => animationController?.reverse());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: MediaQuery.of(context).size.width * 0.1,
      top: MediaQuery.of(context).size.height * 0.80,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          child: FadeTransition(
            opacity: animation!,
            child: Container(
              alignment: Alignment.center,
              color: Colors.black,
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.06,
              child: Text(
                widget.text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
