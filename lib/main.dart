/* Packt Learn Flutter and Dart to Build iOS and Android Apps */
import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'pages/auth.dart';

void main() {
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp is a descendant of Widget
    return MaterialApp(
        // debugShowMaterialGrid: true,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.teal,
            accentColor: Colors.deepOrange),
        home: AuthPage());
  }
}
