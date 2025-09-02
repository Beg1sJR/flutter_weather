import 'package:app/features/weather/data/models/weather_entity/weather_entity.dart';
import 'package:app/features/weather/presentation/logic/details_bloc/weather_details_bloc.dart';
import 'package:app/features/weather/presentation/widgets/weather_details/daily_forecast.dart';
import 'package:app/features/weather/presentation/widgets/weather_details/hourly_forecast.dart';
import 'package:app/features/weather/presentation/widgets/weather_details/weather_app_bar.dart';
import 'package:app/features/weather/presentation/widgets/weather_details/weather_detail_containers.dart';
import 'package:app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class WeatherDetailsPage extends StatefulWidget {
  final String cityName;

  const WeatherDetailsPage({super.key, required this.cityName});

  @override
  State<WeatherDetailsPage> createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  final box = getIt<Box<WeatherEntity>>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(
            builder: (context, state) {
              if (state is WeatherDetailsLoading) {
                return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (state is WeatherDetailsLoaded) {
                return WeatherAppBar(cityName: widget.cityName, state: state);
              } else if (state is WeatherDetailsError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      state.message,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              }
              return const SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
          HourlyForecast(),

          DailyForecast(),

          WeatherDetailContainers(),
        ],
      ),
    );
  }
}
