import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food4good_app/utils/constants.dart';

class DrawRightTriangle extends CustomPainter {
  Paint _paint;

  DrawRightTriangle() {
    _paint = Paint()
      ..color = Constants.FLAG_COLOR
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.height, 0);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
