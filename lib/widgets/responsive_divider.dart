import 'package:flutter/material.dart';
import '../helpers/responsive_calculations.dart';

class ResponsiveDivider extends StatelessWidget {
  const ResponsiveDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).primaryColorDark,
      thickness: ResponsivityHelper.verticalUnit / 8,
    );
  }
}
