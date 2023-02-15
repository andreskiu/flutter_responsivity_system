import 'package:flutter/material.dart';
import 'package:flutter_responsivity_system/helpers/responsive_calculations.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 15;
    var paint2 = Paint()
      ..color = Colors.brown
      ..strokeWidth = 15;
    var paint3 = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 15;

    // Offset start = Offset(0, size.height / 2);
    // Offset end = Offset(size.width, size.height / 2);

    // canvas.drawLine(start, end, paint);
    final _path = Path();
    _path.lineTo(ResponsivityHelper.horizontalUnit * 50,
        ResponsivityHelper.verticalUnit * 50);
    _path.lineTo(ResponsivityHelper.horizontalUnit * 100, 0);
    canvas.drawPath(_path, paint);

    final _path2 = Path();

    _path2.moveTo(0, ResponsivityHelper.verticalUnit * 33);
    _path2.lineTo(
      ResponsivityHelper.horizontalUnit * 50,
      ResponsivityHelper.verticalUnit * 50,
    );
    _path2.lineTo(
      ResponsivityHelper.horizontalUnit * 50,
      ResponsivityHelper.verticalUnit * 50,
    );
    _path2.lineTo(
      ResponsivityHelper.horizontalUnit * 100,
      ResponsivityHelper.verticalUnit * 33,
    );
    _path2.lineTo(
      ResponsivityHelper.horizontalUnit * 100,
      ResponsivityHelper.verticalUnit * 60,
    );
    _path2.lineTo(
      0,
      ResponsivityHelper.verticalUnit * 60,
    );
    canvas.drawPath(_path2, paint2);

    final _path3 = Path();

    _path3.moveTo(
      ResponsivityHelper.horizontalUnit * 22,
      ResponsivityHelper.verticalUnit * 60,
    );
    _path3.lineTo(
      ResponsivityHelper.horizontalUnit * 77,
      ResponsivityHelper.verticalUnit * 60,
    );
    _path3.lineTo(
      ResponsivityHelper.horizontalUnit * 100,
      ResponsivityHelper.verticalUnit * 87,
    );
    _path3.moveTo(
      ResponsivityHelper.horizontalUnit * 77,
      ResponsivityHelper.verticalUnit * 60,
    );
    _path3.lineTo(
      ResponsivityHelper.horizontalUnit * 0,
      ResponsivityHelper.verticalUnit * 87,
    );
    _path3.lineTo(
      ResponsivityHelper.horizontalUnit * 22,
      ResponsivityHelper.verticalUnit * 60,
    );
    canvas.drawPath(_path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
