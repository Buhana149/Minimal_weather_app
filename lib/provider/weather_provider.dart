import 'package:flutter/material.dart';
import 'package:minimal_weather_app/models/weather_model.dart';
import 'package:minimal_weather_app/services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  final _weatherService = WeatherService('250f57fa0ea594a62c37add5ca1d638b');
  Weather? _weather;

  Weather? get weather => _weather;

  fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      _weather = weather;
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
