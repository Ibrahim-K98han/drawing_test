import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Signature extends CustomPainter {
  List<Offset>? points;

  Signature({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;

    for (int i = 0; i < points!.length - 1; i++) {
      canvas.drawLine(points![i], points![i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => oldDelegate.points != points;
}