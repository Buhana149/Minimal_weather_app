import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/provider/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await Provider.of<WeatherProvider>(context, listen: false)
            .fetchWeather();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, value, child) {
      final weatherValue = value.weather;

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
                weatherValue?.cityName ?? 'Loading city..',
                style: TextStyle(fontSize: 30, color: Colors.grey[500]),
              ),
              Lottie.asset(getWeatherAnimation(weatherValue?.mainCondition)),
              Text(
                '${weatherValue?.temperature.round()}°C',
                style: TextStyle(fontSize: 30, color: Colors.grey[500]),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                weatherValue?.mainCondition ?? '',
                style: TextStyle(fontSize: 30, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      );
    });
  }
}
