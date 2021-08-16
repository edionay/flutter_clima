import 'package:flutter/material.dart';
import 'package:flutter_clima/screens/city_screen.dart';
import 'package:flutter_clima/services/weather.dart';
import 'package:flutter_clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.locationWeather);
  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  double temperature = 0.0;
  String city = '';
  String weatherIcon = '';
  String weatherMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(weatherData) {
    setState(() {
      if (weatherData == null) {
        weatherMessage = 'Unable to get weather data';
        weatherIcon = 'Error';
      }

      city = weatherData['name'];
      temperature = weatherData['main']['temp'];
      var condition = weatherData['weather'][0]['id'];
      print(temperature.toInt());
      weatherMessage = weather.getMessage(temperature.toInt());
      weatherIcon = weather.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      weather
                          .getLocationWeather()
                          .then((weatherData) => updateUI(weatherData));
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      dynamic typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      print(typedName);
                      if (typedName != null) {
                        dynamic weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text('${temperature.toInt()}º', style: kTempTextStyle),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$weatherMessage in $city',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
