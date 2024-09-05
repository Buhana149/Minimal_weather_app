import 'package:flutter/material.dart';
import 'package:minimal_weather_app/pages/weather_page.dart';
import 'package:minimal_weather_app/provider/weather_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => WeatherProvider(),

    child:  const MaterialApp(
     debugShowCheckedModeBanner: false,
     home: WeatherPage(),
    ) 
    );
  }

