import 'package:flutter/material.dart';
import 'package:flutter_clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_clima/services/weather.dart';

const kOpenWeatherKey = '21bd8ce69a050fee9fc51bc6dc956c5d';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late double longitude;
  late double latitude;

  void getLocationData() async {
    final weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(weatherData);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRipple(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
