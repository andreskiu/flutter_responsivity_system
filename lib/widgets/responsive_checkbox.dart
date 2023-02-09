import 'package:flutter/material.dart';

import '../helpers/responsive_calculations.dart';

class ResponsiveCheckbox extends StatelessWidget {
  const ResponsiveCheckbox({
    Key? key,
    this.onChange,
    this.value = false,
  }) : super(key: key);

  final Function(bool?)? onChange;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: ResponsivityHelper.verticalUnit / 8,
      child: Checkbox(
        value: value,
        onChanged: onChange,
      ),
    );
  }
}
