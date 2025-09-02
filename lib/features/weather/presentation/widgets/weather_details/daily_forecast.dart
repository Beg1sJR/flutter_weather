import 'package:app/features/weather/presentation/logic/forecast_bloc/forecast_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({super.key});

  String _formatDay(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final now = DateTime.now();

    if (date.day == now.day) return 'Сегодня';
    if (date.day == now.day + 1) return 'Завтра';

    final days = ['Вс', 'Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб'];
    return days[date.weekday % 7];
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
        } else if (state is ForecastLoaded) {
          final forecast = state.forecastDetails;
          final daily = forecast.daily?.take(7).toList() ?? [];

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
                child: Column(
                  children: List.generate(daily.length, (index) {
                    final day = daily[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                            child: Text(
                              _formatDay(day.dt ?? 0),
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),

                          Image.network(
                            'https://openweathermap.org/img/wn/${day.weather?.first.icon}@2x.png',
                            width: 30,
                            height: 30,
                          ),

                          const SizedBox(width: 12),

                          SizedBox(
                            width: 40,
                            child: Text(
                              "${day.temp?.min?.toStringAsFixed(0)}°",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                          ),

                          Expanded(
                            child: Container(
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blueAccent,
                                    Colors.orangeAccent,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),

                          const SizedBox(width: 12),

                          SizedBox(
                            width: 40,
                            child: Text(
                              "${day.temp?.max?.toStringAsFixed(0)}°",
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          );
        } else if (state is ForecastError) {
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
