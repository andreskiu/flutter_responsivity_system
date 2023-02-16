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

    _path2.moveTo(0, 33.verticalProportion());
    _path2.lineTo(
      50.horizontalProportion(),
      50.verticalProportion(),
    );
    _path2.lineTo(
      ResponsivityHelper.horizontalUnit * 50,
      ResponsivityHelper.verticalUnit * 50,
    );
    _path2.lineTo(
      100.horizontalProportion(),
      33.verticalProportion(),
    );
    _path2.lineTo(
      100.horizontalProportion(),
      60.verticalProportion(),
    );
    _path2.lineTo(
      0,
      60.verticalProportion(),
    );
    canvas.drawPath(_path2, paint2);

    final _path3 = Path();

    _path3.moveTo(
      22.horizontalProportion(),
      60.verticalProportion(),
    );
    _path3.lineTo(
      77.horizontalProportion(),
      60.verticalProportion(),
    );
    _path3.lineTo(
      100.horizontalProportion(),
      87.verticalProportion(),
    );
    _path3.moveTo(
      77.horizontalProportion(),
      60.verticalProportion(),
    );
    _path3.lineTo(
      0,
      87.verticalProportion(),
    );
    _path3.lineTo(
      22.horizontalProportion(),
      60.verticalProportion(),
    );
    canvas.drawPath(_path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
