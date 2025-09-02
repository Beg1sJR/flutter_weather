import 'dart:developer';

import 'package:app/features/weather/data/data_source/weather/weather.dart';
import 'package:app/features/weather/data/models/weather_entity/weather_entity.dart';
import 'package:app/features/weather/presentation/logic/favorites_bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection.dart' as di;
import '../../../domain/repository/forecast/forecast.dart';
import '../../../domain/repository/weather/weather.dart';
import '../../logic/details_bloc/weather_details_bloc.dart';
import '../../logic/forecast_bloc/forecast_bloc.dart';
import '../../pages/weather_details_page.dart';

class HomeContainers extends StatelessWidget {
  const HomeContainers({super.key});

  void _openWeatherDetailsPage(BuildContext context, WeatherEntity city) async {
    final dataSource = di.getIt<WeatherData>();
    final coord = await dataSource.getCityCoordinates(city.cityName);
    final lat = coord['lat'];
    final lon = coord['lon'];
    log('Selected city: ${city.cityName}, lat: $lat, lon: $lon');

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  WeatherDetailsBloc(di.getIt<WeatherRepository>())
                    ..add(LoadWeatherDetails(city.cityName)),
            ),
            BlocProvider(
              create: (_) =>
                  ForecastBloc(di.getIt<ForecastRepository>())
                    ..add(LoadForecastDetails(lat, lon)),
            ),
          ],

          child: WeatherDetailsPage(cityName: city.cityName),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return SliverToBoxAdapter(
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is FavoritesLoaded) {
          final cities = state.favorites;
          if (cities.isEmpty) {
            return SliverToBoxAdapter(
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Нет избранных городов'),
                ),
              ),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final city = cities[index];
              final iconUrl =
                  "https://openweathermap.org/img/wn/${city.icon}@2x.png";

              return Container(
                margin: EdgeInsets.only(bottom: 10, left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[800]?.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: city.icon.isNotEmpty
                      ? Image.network(iconUrl)
                      : Icon(Icons.question_answer),
                  title: Text(
                    city.cityName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    '${city.temperature.toStringAsFixed(0)}° | ${city.description} | Мин: ${city.minTemp.toStringAsFixed(0)}° | Макс: ${city.maxTemp.toStringAsFixed(0)}°',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  onTap: () {
                    _openWeatherDetailsPage(context, city);
                  },
                ),
              );
            }, childCount: state.favorites.length),
          );
        } else if (state is FavoritesError) {
          return SliverToBoxAdapter(
            child: Center(child: Text("Ошибка: ${state.message}")),
          );
        }
        return SliverToBoxAdapter(child: const SizedBox.shrink());
      },
    );
  }
}
