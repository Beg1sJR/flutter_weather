import 'package:app/features/weather/data/models/weather_entity/weather_entity.dart';

abstract interface class FavoritesRepository {
  Future<void> addCity(WeatherEntity city);
  List<WeatherEntity> getCities();
  Future<void> removeCity(String cityName);
}
