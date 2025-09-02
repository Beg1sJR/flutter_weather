import 'dart:convert';

import 'package:app/features/weather/data/models/forecast_weather/forecast.dart';
import 'package:app/features/weather/data/models/weather/weather.dart';
import 'package:equatable/equatable.dart';

class DailyModel extends Equatable {
  final int? dt;
  final int? sunrise;
  final int? sunset;
  final int? moonrise;
  final int? moonset;
  final num? moon_phase;
  final String? summary;
  final TempModel? temp;
  final FeelsLikeModel? feels_like;
  final int? pressure;
  final int? humidity;
  final num? dew_point;
  final num? wind_speed;
  final int? wind_deg;
  final num? wind_gust;
  final List<Weather>? weather;
  final int? clouds;
  final num? pop;
  final num? rain;
  final num? uvi;
  const DailyModel({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moon_phase,
    this.summary,
    this.temp,
    this.feels_like,
    this.pressure,
    this.humidity,
    this.dew_point,
    this.wind_speed,
    this.wind_deg,
    this.wind_gust,
    this.weather,
    this.clouds,
    this.pop,
    this.rain,
    this.uvi,
  });

  DailyModel copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    int? moonrise,
    int? moonset,
    num? moon_phase,
    String? summary,
    TempModel? temp,
    FeelsLikeModel? feels_like,
    int? pressure,
    int? humidity,
    num? dew_point,
    num? wind_speed,
    int? wind_deg,
    num? wind_gust,
    List<Weather>? weather,
    int? clouds,
    num? pop,
    num? rain,
    num? uvi,
  }) {
    return DailyModel(
      dt: dt ?? this.dt,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      moonrise: moonrise ?? this.moonrise,
      moonset: moonset ?? this.moonset,
      moon_phase: moon_phase ?? this.moon_phase,
      summary: summary ?? this.summary,
      temp: temp ?? this.temp,
      feels_like: feels_like ?? this.feels_like,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      dew_point: dew_point ?? this.dew_point,
      wind_speed: wind_speed ?? this.wind_speed,
      wind_deg: wind_deg ?? this.wind_deg,
      wind_gust: wind_gust ?? this.wind_gust,
      weather: weather ?? this.weather,
      clouds: clouds ?? this.clouds,
      pop: pop ?? this.pop,
      rain: rain ?? this.rain,
      uvi: uvi ?? this.uvi,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dt': dt,
      'sunrise': sunrise,
      'sunset': sunset,
      'moonrise': moonrise,
      'moonset': moonset,
      'moon_phase': moon_phase,
      'summary': summary,
      'temp': temp?.toMap(),
      'feels_like': feels_like?.toMap(),
      'pressure': pressure,
      'humidity': humidity,
      'dew_point': dew_point,
      'wind_speed': wind_speed,
      'wind_deg': wind_deg,
      'wind_gust': wind_gust,
      'weather': weather?.map((x) => x.toMap()).toList(),
      'clouds': clouds,
      'pop': pop,
      'rain': rain,
      'uvi': uvi,
    };
  }

  factory DailyModel.fromMap(Map<String, dynamic> map) {
    return DailyModel(
      dt: map['dt'] != null ? map['dt'] as int : null,
      sunrise: map['sunrise'] != null ? map['sunrise'] as int : null,
      sunset: map['sunset'] != null ? map['sunset'] as int : null,
      moonrise: map['moonrise'] != null ? map['moonrise'] as int : null,
      moonset: map['moonset'] != null ? map['moonset'] as int : null,
      moon_phase: map['moon_phase'] != null ? map['moon_phase'] as num : null,
      summary: map['summary'] != null ? map['summary'] as String : null,
      temp: map['temp'] != null
          ? TempModel.fromMap(map['temp'] as Map<String, dynamic>)
          : null,
      feels_like: map['feels_like'] != null
          ? FeelsLikeModel.fromMap(map['feels_like'] as Map<String, dynamic>)
          : null,
      pressure: map['pressure'] != null ? map['pressure'] as int : null,
      humidity: map['humidity'] != null ? map['humidity'] as int : null,
      dew_point: map['dew_point'] != null ? map['dew_point'] as num : null,
      wind_speed: map['wind_speed'] != null ? map['wind_speed'] as num : null,
      wind_deg: map['wind_deg'] != null ? map['wind_deg'] as int : null,
      wind_gust: map['wind_gust'] != null ? map['wind_gust'] as num : null,
      weather: map['weather'] != null
          ? List<Weather>.from(
              (map['weather'] as List<dynamic>).map<Weather?>(
                (x) => Weather.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      clouds: map['clouds'] != null ? map['clouds'] as int : null,
      pop: map['pop'] != null ? map['pop'] as num : null,
      rain: map['rain'] != null ? map['rain'] as num : null,
      uvi: map['uvi'] != null ? map['uvi'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DailyModel.fromJson(String source) =>
      DailyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      dt,
      sunrise,
      sunset,
      moonrise,
      moonset,
      moon_phase,
      summary,
      temp,
      feels_like,
      pressure,
      humidity,
      dew_point,
      wind_speed,
      wind_deg,
      wind_gust,
      weather,
      clouds,
      pop,
      rain,
      uvi,
    ];
  }
}
