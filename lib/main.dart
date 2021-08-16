import 'package:flutter/material.dart';
import 'package:flutter_clima/screens/city_screen.dart';
import 'package:flutter_clima/screens/loading_screen.dart';
import 'package:flutter_clima/screens/location_screen.dart';

void main() {
  runApp(ClimaApp());
}

class ClimaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
