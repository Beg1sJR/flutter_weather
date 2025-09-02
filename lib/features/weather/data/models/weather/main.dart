// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class MainModel extends Equatable {
  final num? temp;
  final num? feels_like;
  final num? temp_min;
  final num? temp_max;
  final num? pressure;
  final num? humidity;
  final num? sea_level;
  final num? grnd_level;
  const MainModel({
    this.temp,
    this.feels_like,
    this.temp_min,
    this.temp_max,
    this.pressure,
    this.humidity,
    this.sea_level,
    this.grnd_level,
  });

  MainModel copyWith({
    num? temp,
    num? feels_like,
    num? temp_min,
    num? temp_max,
    num? pressure,
    num? humidity,
    num? sea_level,
    num? grnd_level,
  }) {
    return MainModel(
      temp: temp ?? this.temp,
      feels_like: feels_like ?? this.feels_like,
      temp_min: temp_min ?? this.temp_min,
      temp_max: temp_max ?? this.temp_max,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      sea_level: sea_level ?? this.sea_level,
      grnd_level: grnd_level ?? this.grnd_level,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temp': temp,
      'feels_like': feels_like,
      'temp_min': temp_min,
      'temp_max': temp_max,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': sea_level,
      'grnd_level': grnd_level,
    };
  }

  factory MainModel.fromMap(Map<String, dynamic> map) {
    return MainModel(
      temp: map['temp'] != null ? map['temp'] as num : null,
      feels_like: map['feels_like'] != null ? map['feels_like'] as num : null,
      temp_min: map['temp_min'] != null ? map['temp_min'] as num : null,
      temp_max: map['temp_max'] != null ? map['temp_max'] as num : null,
      pressure: map['pressure'] != null ? map['pressure'] as num : null,
      humidity: map['humidity'] != null ? map['humidity'] as num : null,
      sea_level: map['sea_level'] != null ? map['sea_level'] as num : null,
      grnd_level: map['grnd_level'] != null ? map['grnd_level'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MainModel.fromJson(String source) =>
      MainModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      temp,
      feels_like,
      temp_min,
      temp_max,
      pressure,
      humidity,
      sea_level,
      grnd_level,
    ];
  }
}
