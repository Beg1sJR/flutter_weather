// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class WindModel extends Equatable {
  final num? speed;
  final int? deg;
  final num? gust;
  const WindModel({this.speed, this.deg, this.gust});

  WindModel copyWith({num? speed, int? deg, num? gust}) {
    return WindModel(
      speed: speed ?? this.speed,
      deg: deg ?? this.deg,
      gust: gust ?? this.gust,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'speed': speed, 'deg': deg, 'gust': gust};
  }

  factory WindModel.fromMap(Map<String, dynamic> map) {
    return WindModel(
      speed: map['speed'] != null ? map['speed'] as num : null,
      deg: map['deg'] != null ? map['deg'] as int : null,
      gust: map['gust'] != null ? map['gust'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WindModel.fromJson(String source) =>
      WindModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [speed, deg, gust];
}
