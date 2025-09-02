import 'package:app/features/weather/data/data_source/weather/weather.dart';
import 'package:app/features/weather/data/models/weather/weather_model.dart';
import 'package:app/features/weather/domain/repository/weather/weather.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherData weatherData;

  WeatherRepositoryImpl({required this.weatherData});

  @override
  Future<WeatherModel> getWeather(String cityName) async {
    final WeatherModel weatherDetail = await weatherData.getWeather(cityName);

    return weatherDetail;
  }
}
