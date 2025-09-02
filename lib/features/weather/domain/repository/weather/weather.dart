import 'package:app/features/weather/data/models/weather/weather_export.dart';

abstract interface class WeatherRepository {
  Future<WeatherModel> getWeather(String cityName);
}
