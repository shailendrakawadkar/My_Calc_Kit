import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_calc_kit/files/basic_calcultor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BasicCalculator(),
    );
  }
}
