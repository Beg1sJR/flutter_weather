import 'package:app/features/weather/data/models/weather_entity/weather_entity.dart';
import 'package:app/features/weather/presentation/logic/details_bloc/weather_details_bloc.dart';
import 'package:app/features/weather/presentation/logic/favorites_bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherAppBar extends StatelessWidget {
  const WeatherAppBar({super.key, required this.cityName, required this.state});

  final String cityName;
  final WeatherDetailsLoaded state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weather = state.weatherDetails;

    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, favState) {
        bool isFavorite = false;
        if (favState is FavoritesLoaded) {
          isFavorite = favState.favorites.any(
            (city) => city.cityName == cityName,
          );
        }

        return SliverAppBar(
          centerTitle: true,
          leadingWidth: 100,
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отменить'),
          ),
          title: Text(
            cityName,
            style: theme.textTheme.headlineSmall!.copyWith(
              color: theme.cardColor,
            ),
          ),
          actions: [
            if (!isFavorite)
              TextButton(
                onPressed: () {
                  final entity = WeatherEntity(
                    cityName: cityName,
                    temperature: weather.main?.temp?.toDouble() ?? 0.0,
                    description: weather.weather?.first.description ?? '',
                    maxTemp: weather.main?.temp_max?.toDouble() ?? 0.0,
                    minTemp: weather.main?.temp_min?.toDouble() ?? 0.0,
                    icon: weather.weather?.first.icon ?? '',
                  );

                  context.read<FavoritesBloc>().add(AddFavorite(entity));
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${entity.cityName} добавлен в избранное'),
                    ),
                  );
                },
                child: const Text('Добавить'),
              ),
            if (isFavorite)
              TextButton(
                onPressed: () {
                  context.read<FavoritesBloc>().add(RemoveFavorite(cityName));
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$cityName удалён из избранного')),
                  );
                },
                child: const Text('Удалить'),
              ),
          ],
          automaticallyImplyLeading: false,
          backgroundColor: theme.scaffoldBackgroundColor,
          pinned: true,
          expandedHeight: 100.0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '${weather.weather?.first.description} • Макс: ${weather.main?.temp_max?.toStringAsFixed(0)}° | Мин: ${weather.main?.temp_min?.toStringAsFixed(0)}°',
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: theme.cardColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
