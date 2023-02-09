import 'dart:io';

import 'package:flutter/material.dart';

import '../widgets/device_detector_widget.dart';

class ResponsivityHelper {
  static late MediaQueryData screenData;
  static late double screenWidth;
  static late double screenHeight;
  static late double horizontalUnit;
  static late double verticalUnit;
  static late Orientation orientation;
  static late DeviceScreenType deviceScreenType;
  static late EdgeInsets safeAreaPadding;

  late double _safeAreaHorizontal;
  late double _safeAreaVertical;
  double? safeBlockHorizontal;
  double? safeBlockVertical;

  static late bool useSPForFontSize;
  static late double screenHeightPxReference;
  ResponsivityHelper({
    required MediaQueryData mediaQueryData,
    bool useSPForFontSizeParam = true,
    double screenHeightPxReferenceParam = 0.0,
  }) : assert(
            useSPForFontSizeParam == true || screenHeightPxReferenceParam > 0.0,
            'if useSPForFontSize is false you must specify the screen height of the designs you are following.')
  // assert(screenHeightPxReference == null || screenHeightPxReference > 0,
  //     'Screen height must be greater than 0.')
  {
    useSPForFontSize = useSPForFontSizeParam;
    screenHeightPxReference = screenHeightPxReferenceParam;
    screenData = mediaQueryData;
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    horizontalUnit = screenWidth / 100;
    verticalUnit = screenHeight / 100;

    _safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    orientation = mediaQueryData.orientation;
    deviceScreenType = getDeviceType(mediaQueryData);
    safeAreaPadding = mediaQueryData.padding;
  }

  static double responsiveFontSize(
    int fontSize, {
    bool? useSPForFontSize,
    double? screenHeightPxReference,
  }) {
    // conversion between font size in pixel vs dp. we want to use DP
    // px = dp * (dpi / 160)
    //https://developer.android.com/training/multiscreen/screendensities#TaskUseDP
    final _useSPForFontSize =
        useSPForFontSize ?? ResponsivityHelper.useSPForFontSize;

    final _screenHeightPxReference =
        screenHeightPxReference ?? ResponsivityHelper.screenHeightPxReference;
    // print('DPI: ${ResponsivityHelper.screenData.devicePixelRatio}');
    // print('HEIGHT: ${ResponsivityHelper.screenHeight}');
    // print(
    //     ' text scale factor ${ResponsivityHelper.screenData.textScaleFactor}');
    if (_useSPForFontSize) {
      return fontSize *
          (160 * verticalUnit / ResponsivityHelper.screenHeight) *
          ResponsivityHelper.screenData.textScaleFactor;
    } else {
      return fontSize *
          (_screenHeightPxReference / ResponsivityHelper.screenHeight) *
          ResponsivityHelper.screenData.textScaleFactor;
    }

    // evaluar el reemplazar 160 * vertical unit, por el alto de las pantallas de los diseños de figma. de modo que ese sea la referencia del tamaño de letra.
    // (854 / ResponsivityHelper.screenHeight);

    // print('fontSize $fontSize, Resized: $resizedFontSize');
    // return resizedFontSize;
    double _resizedFontSize = fontSize.toDouble();

    if (Platform.isAndroid) {
      final _factor = (fontSize + 1) / 10;
      _resizedFontSize = _factor * ResponsivityHelper.verticalUnit;
    } else {
      final _factor = (fontSize + 5) / 10;
      _resizedFontSize = _factor * ResponsivityHelper.verticalUnit;
      print(ResponsivityHelper.verticalUnit);
    }
    return _resizedFontSize;
  }
}
