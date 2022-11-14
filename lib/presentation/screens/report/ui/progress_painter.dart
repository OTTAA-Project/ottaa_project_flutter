import 'dart:math';
import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  final double value;
  final Color color;

  double deg2rad(double deg) => deg * pi / 180;

  ProgressPainter({
    required this.value,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    final rect = Rect.fromCenter(center: Offset(size.height / 2, size.width / 2), width: size.width, height: size.height);

    canvas.drawArc(
      rect,
      deg2rad(-90),
      deg2rad(
        (value * 360) / 100, // % to degree
      ),
      true,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
