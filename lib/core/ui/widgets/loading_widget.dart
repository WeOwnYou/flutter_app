import 'dart:math';

import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final bool isActive;
  final double size;
  final Color color;
  const LoadingWidget({
    required this.isActive,
    Key? key,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin<LoadingWidget> {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isActive) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => CustomPaint(
            painter: CirclesPainter(_controller, widget.color),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CirclesPainter extends CustomPainter {
  final AnimationController controller;
  late final Animation<double> degree;
  final Color color;
  CirclesPainter(this.controller, this.color) {
    degree = Tween<double>(begin: 0, end: 360).animate(controller);
  }
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2;
    final circlePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.shortestSide * 0.067
      ..color = color;
    canvas
      ..drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.9334),
        rads(degree.value),
        rads(180),
        false,
        circlePaint,
      )
      ..drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.668),
        rads(degree.value - 90),
        rads(180),
        false,
        circlePaint,
      )
      ..drawArc(
        Rect.fromCircle(center: center, radius: radius * 0.4),
        rads(-degree.value * 3 + 90),
        rads(180),
        false,
        circlePaint,
      );
  }

  double rads(double deg) {
    return deg * pi / 180;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
