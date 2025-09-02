// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:app/features/weather/data/models/weather/weather_export.dart';
import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  final CoordModel? coord;
  final List<Weather>? weather;
  final String? base;
  final MainModel? main;
  final int? visibility;
  final WindModel? wind;
  final CloudsModel? clouds;
  final int? dt;
  final SysModel? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;
  const WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  WeatherModel copyWith({
    CoordModel? coord,
    List<Weather>? weather,
    String? base,
    MainModel? main,
    int? visibility,
    WindModel? wind,
    CloudsModel? clouds,
    int? dt,
    SysModel? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) {
    return WeatherModel(
      coord: coord ?? this.coord,
      weather: weather ?? this.weather,
      base: base ?? this.base,
      main: main ?? this.main,
      visibility: visibility ?? this.visibility,
      wind: wind ?? this.wind,
      clouds: clouds ?? this.clouds,
      dt: dt ?? this.dt,
      sys: sys ?? this.sys,
      timezone: timezone ?? this.timezone,
      id: id ?? this.id,
      name: name ?? this.name,
      cod: cod ?? this.cod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coord': coord?.toMap(),
      'weather': weather?.map((x) => x.toMap()).toList(),
      'base': base,
      'main': main?.toMap(),
      'visibility': visibility,
      'wind': wind?.toMap(),
      'clouds': clouds?.toMap(),
      'dt': dt,
      'sys': sys?.toMap(),
      'timezone': timezone,
      'id': id,
      'name': name,
      'cod': cod,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      coord: map['coord'] != null
          ? CoordModel.fromMap(map['coord'] as Map<String, dynamic>)
          : null,
      weather: map['weather'] != null
          ? List<Weather>.from(
              (map['weather'] as List<dynamic>).map<Weather?>(
                (x) => Weather.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      base: map['base'] != null ? map['base'] as String : null,
      main: map['main'] != null
          ? MainModel.fromMap(map['main'] as Map<String, dynamic>)
          : null,
      visibility: map['visibility'] != null ? map['visibility'] as int : null,
      wind: map['wind'] != null
          ? WindModel.fromMap(map['wind'] as Map<String, dynamic>)
          : null,
      clouds: map['clouds'] != null
          ? CloudsModel.fromMap(map['clouds'] as Map<String, dynamic>)
          : null,
      dt: map['dt'] != null ? map['dt'] as int : null,
      sys: map['sys'] != null
          ? SysModel.fromMap(map['sys'] as Map<String, dynamic>)
          : null,
      timezone: map['timezone'] != null ? map['timezone'] as int : null,
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      cod: map['cod'] != null ? map['cod'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      coord,
      weather,
      base,
      main,
      visibility,
      wind,
      clouds,
      dt,
      sys,
      timezone,
      id,
      name,
      cod,
    ];
  }
}
