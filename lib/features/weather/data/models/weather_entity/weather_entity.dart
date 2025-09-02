import 'package:hive/hive.dart';

part 'weather_entity.g.dart';

@HiveType(typeId: 0)
class WeatherEntity {
  @HiveField(0)
  final String cityName;
  @HiveField(1)
  final double temperature;
  @HiveField(2)
  final double maxTemp;
  @HiveField(3)
  final double minTemp;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final String icon;

  WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.maxTemp,
    required this.minTemp,
    required this.description,
    required this.icon,
  });
}
