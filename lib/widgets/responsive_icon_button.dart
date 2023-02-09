import 'package:flutter/material.dart';

import '../helpers/responsive_calculations.dart';

class ResponsiveIconButton extends StatelessWidget {
  final double size;
  final Function()? onPressed;
  final IconData icon;
  const ResponsiveIconButton({
    Key? key,
    required this.size,
    this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: ResponsivityHelper.verticalUnit * size,
        color: Theme.of(context).iconTheme.color,
      ),
      constraints: BoxConstraints.tightFor(
        width: ResponsivityHelper.verticalUnit * size,
        height: ResponsivityHelper.verticalUnit * size,
      ),
      splashRadius: ResponsivityHelper.verticalUnit * size,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
    );
  }
}
