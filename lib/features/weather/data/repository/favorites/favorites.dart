import 'package:app/features/weather/data/models/weather_entity/weather_entity.dart';
import 'package:app/features/weather/domain/repository/favorites/favorites.dart';
import 'package:hive/hive.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final Box<WeatherEntity> favoritesBox;

  FavoritesRepositoryImpl(this.favoritesBox);

  @override
  Future<void> addCity(WeatherEntity city) async {
    await favoritesBox.put(city.cityName, city);
  }

  @override
  List<WeatherEntity> getCities() {
    return favoritesBox.values.toList();
  }

  @override
  Future<void> removeCity(String cityName) async {
    await favoritesBox.delete(cityName);
  }
}
