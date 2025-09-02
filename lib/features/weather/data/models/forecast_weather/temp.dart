// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class TempModel extends Equatable {
  final num? day;
  final num? min;
  final num? max;
  final num? night;
  final num? eve;
  final num? morn;
  const TempModel({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  TempModel copyWith({
    num? day,
    num? min,
    num? max,
    num? night,
    num? eve,
    num? morn,
  }) {
    return TempModel(
      day: day ?? this.day,
      min: min ?? this.min,
      max: max ?? this.max,
      night: night ?? this.night,
      eve: eve ?? this.eve,
      morn: morn ?? this.morn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'min': min,
      'max': max,
      'night': night,
      'eve': eve,
      'morn': morn,
    };
  }

  factory TempModel.fromMap(Map<String, dynamic> map) {
    return TempModel(
      day: map['day'] != null ? map['day'] as num : null,
      min: map['min'] != null ? map['min'] as num : null,
      max: map['max'] != null ? map['max'] as num : null,
      night: map['night'] != null ? map['night'] as num : null,
      eve: map['eve'] != null ? map['eve'] as num : null,
      morn: map['morn'] != null ? map['morn'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TempModel.fromJson(String source) =>
      TempModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [day, min, max, night, eve, morn];
  }
}
