import 'package:flutter/material.dart';

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
    _path.lineTo(
      size.width * 0.5,
      size.height * 0.5,
    );
    _path.lineTo(
      size.width,
      0,
    );
    canvas.drawPath(_path, paint);

    final _path2 = Path();

    _path2.moveTo(0, size.height * 33 / 100);
    _path2.lineTo(
      size.width * 0.5,
      size.height * 0.5,
    );
    _path2.lineTo(
      size.width * 0.5,
      size.height * 0.5,
    );
    _path2.lineTo(
      size.width,
      size.height * 33 / 100,
    );
    _path2.lineTo(
      size.width,
      size.height * 60 / 100,
    );
    _path2.lineTo(
      0,
      size.height * 60 / 100,
    );
    canvas.drawPath(_path2, paint2);

    final _path3 = Path();

    _path3.moveTo(
      size.width * 22 / 100,
      size.height * 60 / 100,
    );
    _path3.lineTo(
      size.width * 77 / 100,
      size.height * 60 / 100,
    );
    _path3.lineTo(
      size.width,
      size.height * 87 / 100,
    );
    _path3.moveTo(
      size.width * 77 / 100,
      size.height * 60 / 100,
    );
    _path3.lineTo(
      0,
      size.height * 87 / 100,
    );
    _path3.lineTo(
      size.width * 22 / 100,
      size.height * 60 / 100,
    );
    canvas.drawPath(_path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
