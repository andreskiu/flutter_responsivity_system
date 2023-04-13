<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

## Adjust your app to all screen sizes keeping its beauty in all devices.

This package will allow your widgets adjust its size using a percentage of the screen size or taking as reference the dimensions of your designer screen so your app will look similar in all devices.


## Getting started

This package was inspired by [Daniele Cambi's post](https://medium.com/flutter-community/flutter-effectively-scale-ui-according-to-different-screen-sizes-2cb7c115ea0a). Take a look at it for more undestanding on how this package works.

## Initialization

It is important to initialize the package as soon as possible. However, to do so, it is required to have access to the context and the media query, and that's available after the creation of the MaterialApp. For example, we are going to initialize the package in the builder function of the material app in the main file (see example):

```dart
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      builder: (context, child) {
        ResponsivityHelper(
          mediaQueryData: MediaQuery.of(context),
        );
        return child!;
      },
    );
  }
```

By default, the package will work using a percentage of the screen. If you want to keep your designs proportional to your designer's screen, it is required to set the size of that screen as follows:


```dart
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      builder: (context, child) {
        ResponsivityHelper(
          mediaQueryData: MediaQuery.of(context),
          useDesignSizeAsReference: true,
          screenReferenceSizeParam: const Size(375, 812),
        );
        return child!;
      },
    );
  }
```

Also you can set the strategy to use for the font size using the param 

```dart
fontSizeModeParam: FontSizeMode.referenceScreenValue,
```

[referenceScreenValue]: Will adjust the font size according to the size of the screen of the design. Uses screenReferenceSize for calculations

[screenPercent]: Will adjust the font sizes according the size of the phone screen. Each point represents the 0.1% of the screen size, so a font size of 16 means the 1.6% of the screen height

[androidSPStrategy]: Will adjust the font sizes in a similar way than android devices theoretically

[devicePixelRatio]: Will multyply font size by device pixel ratio.


## Usage

Just multiply every size for the factor calculated by the package. 

So, if you want to create a rectagle of 50% of the phones height and 21.5% of phone's width, 

```dart
 Container(
    height: 50 * ResponsivityHelper.verticalUnit,
    width: 21.5 * ResponsivityHelper.horizontalUnit,
    ),
// or the same

 Container(
    height: 50.verticalPercent(),
    width: 21.5.horizontalPercent(),
 )
```

For texts, You can set the font size using:
```dart
 Text(
    'Your text',
    style: TextStyle(
            fontSize: ResponsivityHelper.responsiveFontSize(17), // set the size here
            color: color,
            fontWeight: fontWeight,
            ),
    );
```

Or just use the ResponsiveText widget

```dart
ResponsiveText(
    'Your text',
    textAlign: TextAlign.center,
    fontSize: 20,
    color: Colors.black,
    ),
```

Or just use the ResponsiveText widget
## Widgets

### DeviceLayoutSelector
 This widget will change its child according to the size of the device, allowing you to create different views for different screen sizes, for example mobile, tablet or desktop
```dart
DeviceLayoutSelector(
    mobileBuilder: () {
    const ResponsiveText(
        'Mobile design',
        textAlign: TextAlign.center,
        color: Colors.black,
    );
    },
    pcBuilder: () {
    return const ResponsiveText(
        'Desktop design',
        textAlign: TextAlign.center,
        color: Colors.black,
    );
    },
    tabletBuilder: () {
    return const ResponsiveText(
        'Tablet design:',
        textAlign: TextAlign.center,
        color: Colors.black,
    );
    },
),
```
### OrientationLayout
This widget will change its child according the orientation of the screen: landscape or portrait:

```dart
OrientationLayout(
    portrait: () {
    return const ResponsiveText(
        'Mobile design portrait',
        textAlign: TextAlign.center,
        color: Colors.black,
    );
    },
    landscape: () {
    return const ResponsiveText(
        'Mobile design landscape',
        textAlign: TextAlign.center,
        color: Colors.black,
    );
    },
);
```
