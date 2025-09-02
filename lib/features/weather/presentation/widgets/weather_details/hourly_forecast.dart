import 'package:app/features/weather/presentation/logic/forecast_bloc/forecast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast({super.key});

  String _formatTime(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.hour}:00';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ForecastBloc, ForecastState>(
      builder: (context, state) {
        if (state is ForecastLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ForecastLoaded) {
          final forecast = state.forecastDetails;
          final hourly = forecast.hourly?.take(12).toList() ?? [];

          return SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[800]?.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: 120,
                  child: ListView.builder(
                    itemCount: hourly.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hour = hourly[index];
                      return Container(
                        width: 60,
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _formatTime(hour.dt ?? 0),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            Image.network(
                              'https://openweathermap.org/img/wn/${hour.weather?.first.icon}@2x.png',
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${hour.temp?.toStringAsFixed(0)}°',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
        if (state is ForecastError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                state.message,
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
