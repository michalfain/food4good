import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/utils/constants.dart';

class DrawTriangle extends CustomPainter {
  Paint _paint;

  DrawTriangle() {
    _paint = Paint()
      ..color = Constants.FLAG_COLOR
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
