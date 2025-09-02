import 'package:app/features/weather/data/data_source/forecast/forecast.dart';
// import 'package:app/features/weather/data/data_source/weather/weather.dart';
import 'package:app/features/weather/data/models/forecast_weather/forecast.dart';
import 'package:app/features/weather/domain/repository/forecast/forecast.dart';

class ForecastRepositoryImpl implements ForecastRepository {
  final ForecastData forecastData;

  ForecastRepositoryImpl({required this.forecastData});

  @override
  Future<ForecastWeatherModel> getForecast(num lat, num lon) async {
    final ForecastWeatherModel forecastDetails = await forecastData.getForecast(
      lat,
      lon,
    );

    return forecastDetails;
  }
}
