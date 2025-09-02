import 'package:app/features/weather/presentation/logic/details_bloc/weather_details_bloc.dart';
import 'package:app/features/weather/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDetailContainers extends StatelessWidget {
  const WeatherDetailContainers({super.key});

  String formatVisibility(int visibility) {
    if (visibility >= 1000) {
      double km = visibility / 1000;
      return "${km.toStringAsFixed(km.truncateToDouble() == km ? 0 : 1)} км";
    } else {
      return "$visibility м";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(
      builder: (context, state) {
        if (state is WeatherDetailsLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is WeatherDetailsLoaded) {
          final weather = state.weatherDetails;

          return SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildListDelegate([
                DetailsContainer(
                  text: 'Ощущается как',
                  info: '${weather.main?.feels_like?.toStringAsFixed(0)}°',
                  icon: Icons.thermostat_auto_rounded,
                ),
                DetailsContainer(
                  text: 'Ветер',
                  info:
                      '${weather.wind?.speed?.toInt().toStringAsFixed(1)} м/с',
                  icon: Icons.wind_power_outlined,
                  bottomText: 'Направление: ${weather.wind?.deg}°',
                ),
                DetailsContainer(
                  text: 'Видимость',
                  info: formatVisibility(weather.visibility ?? 0),
                  icon: Icons.visibility,
                ),
                DetailsContainer(
                  text: 'Влажность',
                  info: '${weather.main?.humidity?.toStringAsFixed(0)}%',
                  icon: Icons.water_drop_outlined,
                ),
                DetailsContainer(
                  text: 'Восход',
                  info: weather.sys?.sunrise != null
                      ? TimeOfDay.fromDateTime(
                          DateTime.fromMillisecondsSinceEpoch(
                            weather.sys!.sunrise! * 1000,
                          ),
                        ).format(context)
                      : 'N/A',
                  icon: Icons.sunny,
                  bottomText:
                      'Закат: ${weather.sys?.sunset != null ? TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(weather.sys!.sunset! * 1000)).format(context) : 'N/A'}',
                ),
                DetailsContainer(
                  text: 'Давление',
                  info: '${weather.main?.pressure}',
                  icon: Icons.speed,
                  bottomText: 'гПа',
                ),
              ]),
            ),
          );
        } else if (state is WeatherDetailsError) {
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
