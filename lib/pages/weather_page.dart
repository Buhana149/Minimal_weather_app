import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('250f57fa0ea594a62c37add5ca1d638b');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets1/sun.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets1/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets1/rain.jon';
      case 'thunderstorm':
        return 'assets1/thunder.json';
      case 'clear':
        return 'assets1/sun.json';
      default:
        return 'assets1/sun.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 40,
              color: Colors.grey[500],
            ),
            Text(
              _weather?.cityName ?? 'Loading city..',
              style: TextStyle(fontSize: 30, color: Colors.grey[500]),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              '${_weather?.temperature.round()}°C',
              style: TextStyle(fontSize: 30, color: Colors.grey[500]),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              _weather?.mainCondition ?? '',
              style: TextStyle(fontSize: 30, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
    );
  }
}
