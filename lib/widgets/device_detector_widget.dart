import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Enums for different screen sizes
enum DeviceScreenType { mobile, tablet, pc }

/// GetDeviceType Function
/// This is where we define our screen widths for different layouts
DeviceScreenType getDeviceType(MediaQueryData mediaQueryData) {
  var orientation = mediaQueryData.orientation;

  var deviceWidth = 0.0;

  print('aspect ratio: ${mediaQueryData.size.aspectRatio}');
  if (kIsWeb) {
    // 2/3 is the worst phone aspect ratio. so if screen is 9/16, 4/5 or 2/3 it will be treated as a phone
    if (mediaQueryData.size.aspectRatio < (2 / 3)) {
      deviceWidth = mediaQueryData.size.height;
    } else {
      deviceWidth = mediaQueryData.size.width;
    }
  } else {
    if (orientation == Orientation.landscape) {
      deviceWidth = mediaQueryData.size.height;
    } else {
      deviceWidth = mediaQueryData.size.width;
    }
  }
  if (deviceWidth > 1000) {
    return DeviceScreenType.pc;
  }

  if (deviceWidth > 600) {
    return DeviceScreenType.tablet;
  }

  return DeviceScreenType.mobile;
}

class OrientationLayout extends StatelessWidget {
  final Widget Function() landscape;
  final Widget Function()? portrait;

  const OrientationLayout({
    Key? key,
    required this.landscape,
    this.portrait,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.landscape) {
      return landscape();
    }

    return portrait!();
  }
}

class DeviceLayoutSelector extends StatelessWidget {
  final Widget Function() mobileBuilder;
  final Widget Function()? tabletBuilder;
  final Widget Function()? pcBuilder;

  const DeviceLayoutSelector({
    Key? key,
    required this.mobileBuilder,
    this.tabletBuilder,
    this.pcBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _device = getDeviceType(MediaQuery.of(context));
    switch (_device) {
      case DeviceScreenType.mobile:
        return mobileBuilder();

      case DeviceScreenType.tablet:
        if (tabletBuilder != null) {
          return tabletBuilder!();
        }
        return mobileBuilder();
      case DeviceScreenType.pc:
        if (pcBuilder != null) {
          return pcBuilder!();
        }
        return mobileBuilder();

      default:
        return mobileBuilder();
    }
  }
}
