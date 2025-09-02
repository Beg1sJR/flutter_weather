// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/features/weather/data/models/weather/weather.dart';
import 'package:equatable/equatable.dart';

class HourlyModel extends Equatable {
  final int? dt;
  final num? temp;
  final num? feels_like;
  final int? pressure;
  final int? humidity;
  final num? dew_point;
  final num? uvi;
  final int? clouds;
  final int? visibility;
  final num? wind_speed;
  final int? wind_deg;
  final num? wind_gust;
  final List<Weather>? weather;
  final num? pop;
  const HourlyModel({
    this.dt,
    this.temp,
    this.feels_like,
    this.pressure,
    this.humidity,
    this.dew_point,
    this.uvi,
    this.clouds,
    this.visibility,
    this.wind_speed,
    this.wind_deg,
    this.wind_gust,
    this.weather,
    this.pop,
  });

  HourlyModel copyWith({
    int? dt,
    num? temp,
    num? feels_like,
    int? pressure,
    int? humidity,
    num? dew_point,
    num? uvi,
    int? clouds,
    int? visibility,
    num? wind_speed,
    int? wind_deg,
    num? wind_gust,
    List<Weather>? weather,
    num? pop,
  }) {
    return HourlyModel(
      dt: dt ?? this.dt,
      temp: temp ?? this.temp,
      feels_like: feels_like ?? this.feels_like,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      dew_point: dew_point ?? this.dew_point,
      uvi: uvi ?? this.uvi,
      clouds: clouds ?? this.clouds,
      visibility: visibility ?? this.visibility,
      wind_speed: wind_speed ?? this.wind_speed,
      wind_deg: wind_deg ?? this.wind_deg,
      wind_gust: wind_gust ?? this.wind_gust,
      weather: weather ?? this.weather,
      pop: pop ?? this.pop,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dt': dt,
      'temp': temp,
      'feels_like': feels_like,
      'pressure': pressure,
      'humidity': humidity,
      'dew_point': dew_point,
      'uvi': uvi,
      'clouds': clouds,
      'visibility': visibility,
      'wind_speed': wind_speed,
      'wind_deg': wind_deg,
      'wind_gust': wind_gust,
      'weather': weather?.map((x) => x.toMap()).toList(),
      'pop': pop,
    };
  }

  factory HourlyModel.fromMap(Map<String, dynamic> map) {
    return HourlyModel(
      dt: map['dt'] != null ? map['dt'] as int : null,
      temp: map['temp'] != null ? map['temp'] as num : null,
      feels_like: map['feels_like'] != null ? map['feels_like'] as num : null,
      pressure: map['pressure'] != null ? map['pressure'] as int : null,
      humidity: map['humidity'] != null ? map['humidity'] as int : null,
      dew_point: map['dew_point'] != null ? map['dew_point'] as num : null,
      uvi: map['uvi'] != null ? map['uvi'] as num : null,
      clouds: map['clouds'] != null ? map['clouds'] as int : null,
      visibility: map['visibility'] != null ? map['visibility'] as int : null,
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
      pop: map['pop'] != null ? map['pop'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HourlyModel.fromJson(String source) =>
      HourlyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      dt,
      temp,
      feels_like,
      pressure,
      humidity,
      dew_point,
      uvi,
      clouds,
      visibility,
      wind_speed,
      wind_deg,
      wind_gust,
      weather,
      pop,
    ];
  }
}
