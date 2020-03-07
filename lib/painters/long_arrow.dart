import 'package:flutter/material.dart';

class LongArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(_drawShaftPath(), paint);
    canvas.drawPath(_drawTipPath(), paint);
  }

  Path _drawShaftPath() {
    return Path()
      ..moveTo(-50, 0)
      ..lineTo(50, 0);
  }

  Path _drawTipPath() {
    return Path()
      ..moveTo(50, -10)
      ..lineTo(60, 0)
      ..lineTo(50, 10);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
