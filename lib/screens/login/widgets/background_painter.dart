import 'package:flutter/material.dart';

import '../../../constants/theme_color.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = ThemeColor.level4
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height * 0.9)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.7, size.width * 0.6, size.height * 0.9)
      ..quadraticBezierTo(size.width * 0.8, size.height * 1, size.width, size.height * 0.9)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    var paint2 = Paint()
      ..color = ThemeColor.level1
      ..style = PaintingStyle.fill;

    var path2 = Path()
      ..moveTo(0, size.height * 0.9)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.8, size.width * 0.6, size.height * 0.95)
      ..quadraticBezierTo(size.width * 0.8, size.height * 1.05, size.width, size.height * 1)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    canvas.drawPath(path2, paint2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
