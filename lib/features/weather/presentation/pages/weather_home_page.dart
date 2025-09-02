import 'package:app/features/weather/presentation/widgets/weather_home/home_app_bar.dart';
import 'package:app/features/weather/presentation/widgets/weather_home/home_containers.dart';
import 'package:flutter/material.dart';

class WeatherHomePage extends StatefulWidget {
  const WeatherHomePage({super.key});

  @override
  State<WeatherHomePage> createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [HomeAppBar(), HomeContainers()]),
    );
  }
}
