// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CoordModel extends Equatable {
  final num? lon;
  final num? lat;
  const CoordModel({this.lon, this.lat});

  CoordModel copyWith({num? lon, num? lat}) {
    return CoordModel(lon: lon ?? this.lon, lat: lat ?? this.lat);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'lon': lon, 'lat': lat};
  }

  factory CoordModel.fromMap(Map<String, dynamic> map) {
    return CoordModel(
      lon: map['lon'] != null ? map['lon'] as num : null,
      lat: map['lat'] != null ? map['lat'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoordModel.fromJson(String source) =>
      CoordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [lon, lat];
}
