import 'package:flutter/material.dart';
import '../helpers/responsive_calculations.dart';

class ResponsiveCircularIndicator extends StatelessWidget {
  const ResponsiveCircularIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      strokeWidth: ResponsivityHelper.verticalUnit / 2,
    );
  }
}
