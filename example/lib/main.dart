import 'package:flutter/material.dart';
import 'package:flutter_responsivity_system/helpers/responsive_calculations.dart';
import 'package:flutter_responsivity_system/widgets/device_detector_widget.dart';
import 'package:flutter_responsivity_system/widgets/responsive_text.dart';

import 'my_painter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
          fontSizeModeParam: FontSizeMode.referenceScreenValue,
        );
        return child!;
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: MyPainter(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.horizontalProportion(),
                ),
                child: DeviceLayoutSelector(
                  mobileBuilder: () {
                    return OrientationLayout(
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
              ),
              const ResponsiveText(
                'You have pushed the button this many times:',
                textAlign: TextAlign.center,
                fontSize: 20,
                color: Colors.black,
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              2.2.verticalProportion(),
              // ResponsivityHelper.horizontalUnit * 2,
            ),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
