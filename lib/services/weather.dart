import 'package:flutter_clima/services/location.dart';
import 'package:flutter_clima/services/networking.dart';

const openWeatherKey = '21bd8ce69a050fee9fc51bc6dc956c5d';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future getCityWeather(String cityName) async {
    final url = Uri.parse(
        '$openWeatherMapUrl?units=metric&q=$cityName&appid=$openWeatherKey');
    NetworkHelper networkHelper = NetworkHelper(url);
    final weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    final url = Uri.parse(
        '$openWeatherMapUrl?units=metric&lat=${location.latitude}&lon=${location.longitude}&appid=$openWeatherKey');

    NetworkHelper networkHelper = NetworkHelper(url);

    final weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
