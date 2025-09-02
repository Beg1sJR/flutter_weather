// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CloudsModel extends Equatable {
  final int? all;
  const CloudsModel({this.all});

  CloudsModel copyWith({int? all}) {
    return CloudsModel(all: all ?? this.all);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'all': all};
  }

  factory CloudsModel.fromMap(Map<String, dynamic> map) {
    return CloudsModel(all: map['all'] != null ? map['all'] as int : null);
  }

  String toJson() => json.encode(toMap());

  factory CloudsModel.fromJson(String source) =>
      CloudsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [all];
}
