// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class FeelsLikeModel extends Equatable {
  final num? day;
  final num? night;
  final num? eve;
  final num? morn;
  const FeelsLikeModel({this.day, this.night, this.eve, this.morn});

  FeelsLikeModel copyWith({num? day, num? night, num? eve, num? morn}) {
    return FeelsLikeModel(
      day: day ?? this.day,
      night: night ?? this.night,
      eve: eve ?? this.eve,
      morn: morn ?? this.morn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'night': night,
      'eve': eve,
      'morn': morn,
    };
  }

  factory FeelsLikeModel.fromMap(Map<String, dynamic> map) {
    return FeelsLikeModel(
      day: map['day'] != null ? map['day'] as num : null,
      night: map['night'] != null ? map['night'] as num : null,
      eve: map['eve'] != null ? map['eve'] as num : null,
      morn: map['morn'] != null ? map['morn'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeelsLikeModel.fromJson(String source) =>
      FeelsLikeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [day, night, eve, morn];
}
