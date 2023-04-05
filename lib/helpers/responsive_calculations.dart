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
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static late FontSizeMode fontSizeMode;
  static late bool useDesignSizeAsReference;
  static late Size screenReferenceSize;
  static late double screenHeightPxReference;
  static late double screenWidthPxReference;
  ResponsivityHelper({
    required MediaQueryData mediaQueryData,
    bool useDesignSizeAsReference = false,
    FontSizeMode fontSizeModeParam = FontSizeMode.devicePixelRatio,
    Size screenReferenceSizeParam = const Size(0, 0),
  })  : assert(
            fontSizeModeParam == FontSizeMode.referenceScreenValue ||
                screenReferenceSizeParam.height > 0.0,
            'if useSPForFontSize is false you must specify the screen height of the designs you are following.'),
        assert(
            !(useDesignSizeAsReference == true &&
                (screenReferenceSizeParam.height < 10 ||
                    screenReferenceSizeParam.width < 10)),
            'If useDesignSizeAsReference is true, then you need to specify the screen size that you will take as reference') {
    fontSizeMode = fontSizeModeParam;
    screenHeightPxReference = screenReferenceSizeParam.height;
    screenWidthPxReference = screenReferenceSizeParam.width;
    screenData = mediaQueryData;
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    horizontalUnit = useDesignSizeAsReference
        ? screenWidth / screenWidthPxReference
        : screenWidth / 100;
    verticalUnit = useDesignSizeAsReference
        ? screenHeight / screenHeightPxReference
        : screenHeight / 100;

    _safeAreaHorizontal =
        mediaQueryData.padding.left + mediaQueryData.padding.right;
    _safeAreaVertical =
        mediaQueryData.padding.top + mediaQueryData.padding.bottom;

    safeBlockHorizontal = useDesignSizeAsReference
        ? (screenWidth - _safeAreaHorizontal) / screenWidthPxReference
        : (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = useDesignSizeAsReference
        ? (screenHeight - _safeAreaVertical) / screenHeightPxReference
        : (screenHeight - _safeAreaVertical) / 100;

    orientation = mediaQueryData.orientation;
    deviceScreenType = getDeviceType(mediaQueryData);
    safeAreaPadding = mediaQueryData.padding;
  }

  static double responsiveFontSize(
    int fontSize, {
    double? screenHeightPxReference,
    FontSizeMode? fontSizeMode,
  }) {
    final _screenHeightPxReference =
        screenHeightPxReference ?? ResponsivityHelper.screenHeightPxReference;
    final _fontSizeMode = fontSizeMode ?? ResponsivityHelper.fontSizeMode;

    switch (_fontSizeMode) {
      case FontSizeMode.screenPercent:
        final _verticalUnit = screenHeight / 100;
        // divide into 10 just to make font sizes numbers similar to the ones on figma.
        // otherwise you will need to specify the font size as a percetage of the screen.
        return (fontSize * _verticalUnit / 10) *
            ResponsivityHelper.screenData.textScaleFactor;
      case FontSizeMode.devicePixelRatio:
        return fontSize *
            screenData.devicePixelRatio *
            ResponsivityHelper.screenData.textScaleFactor;

      case FontSizeMode.androidSPStrategy:
        // conversion between font size in pixel vs dp. we want to use DP
        // px = dp * (dpi / 160)
        //https://developer.android.com/training/multiscreen/screendensities#TaskUseDP
        final _verticalUnit = screenHeight / 100;
        return fontSize *
            (160 * _verticalUnit / ResponsivityHelper.screenHeight) *
            ResponsivityHelper.screenData.textScaleFactor;
      case FontSizeMode.referenceScreenValue:
        return fontSize *
            (ResponsivityHelper.screenHeight / _screenHeightPxReference) *
            ResponsivityHelper.screenData.textScaleFactor;
    }

    // evaluar el reemplazar 160 * vertical unit, por el alto de las pantallas de los diseños de figma. de modo que ese sea la referencia del tamaño de letra.
    // (854 / ResponsivityHelper.screenHeight);

    double _resizedFontSize = fontSize.toDouble();
    // previous android strategy - works fine
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

enum FontSizeMode {
  devicePixelRatio,
  androidSPStrategy,
  referenceScreenValue,
  screenPercent
}

extension ResponsivityExtension on int {
  double verticalPercent({
    bool useSafeArea = false,
  }) {
    if (useSafeArea) {
      return this * ResponsivityHelper.safeBlockVertical;
    }
    return this * ResponsivityHelper.verticalUnit;
  }

  double horizontalPercent({
    bool useSafeArea = false,
  }) {
    if (useSafeArea) {
      return this * ResponsivityHelper.safeBlockHorizontal;
    }
    return this * ResponsivityHelper.horizontalUnit;
  }
}

extension ResponsivityExtensionDouble on double {
  double verticalPercent({
    bool useSafeArea = false,
  }) {
    if (useSafeArea) {
      return this * ResponsivityHelper.safeBlockVertical;
    }
    return this * ResponsivityHelper.verticalUnit;
  }

  double horizontalPercent({
    bool useSafeArea = false,
  }) {
    if (useSafeArea) {
      return this * ResponsivityHelper.safeBlockHorizontal;
    }
    return this * ResponsivityHelper.horizontalUnit;
  }
}
