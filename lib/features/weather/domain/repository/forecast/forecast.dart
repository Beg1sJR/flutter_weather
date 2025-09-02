import 'package:app/features/weather/data/models/forecast_weather/forecast.dart';

abstract interface class ForecastRepository {
  Future<ForecastWeatherModel> getForecast(num lat, num lon);
}
