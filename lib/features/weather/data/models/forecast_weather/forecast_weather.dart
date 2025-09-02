// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/features/weather/data/models/forecast_weather/forecast.dart';
import 'package:equatable/equatable.dart';

class ForecastWeatherModel extends Equatable {
  final num? lat;
  final num? lon;
  final String? timezone;
  final int? timezoneOffset;
  final List<DailyModel>? daily;
  final List<HourlyModel>? hourly;
  const ForecastWeatherModel({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.daily,
    this.hourly,
  });

  ForecastWeatherModel copyWith({
    num? lat,
    num? lon,
    String? timezone,
    int? timezoneOffset,
    List<DailyModel>? daily,
    List<HourlyModel>? hourly,
  }) {
    return ForecastWeatherModel(
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      timezone: timezone ?? this.timezone,
      timezoneOffset: timezoneOffset ?? this.timezoneOffset,
      daily: daily ?? this.daily,
      hourly: hourly ?? this.hourly,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'lon': lon,
      'timezone': timezone,
      'timezoneOffset': timezoneOffset,
      'daily': daily?.map((x) => x.toMap()).toList(),
      'hourly': hourly?.map((x) => x.toMap()).toList(),
    };
  }

  factory ForecastWeatherModel.fromMap(Map<String, dynamic> map) {
    return ForecastWeatherModel(
      lat: map['lat'] != null ? map['lat'] as num : null,
      lon: map['lon'] != null ? map['lon'] as num : null,
      timezone: map['timezone'] != null ? map['timezone'] as String : null,
      timezoneOffset: map['timezone_offset'] != null
          ? map['timezone_offset'] as int
          : null,
      daily: map['daily'] != null
          ? List<DailyModel>.from(
              (map['daily'] as List<dynamic>).map<DailyModel>(
                (x) => DailyModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      hourly: map['hourly'] != null
          ? List<HourlyModel>.from(
              (map['hourly'] as List<dynamic>).map<HourlyModel>(
                (x) => HourlyModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForecastWeatherModel.fromJson(String source) =>
      ForecastWeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [lat, lon, timezone, timezoneOffset, daily, hourly];
  }
}
