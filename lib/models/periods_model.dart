import 'dart:convert';

import 'package:equatable/equatable.dart';

class PeriodsModel extends Equatable {
  final dynamic name;
  final String? startTime;
  final String? endTime;
  final String? id;

  const PeriodsModel({this.name, this.startTime, this.endTime, this.id});

  factory PeriodsModel.fromMap(Map<String, dynamic> data) => PeriodsModel(
        name: data['name'] as dynamic,
        startTime: data['start_time'] as String?,
        endTime: data['end_time'] as String?,
        id: data['id'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'start_time': startTime,
        'end_time': endTime,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PeriodsModel].
  factory PeriodsModel.fromJson(String data) {
    return PeriodsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PeriodsModel] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, startTime, endTime, id];
}
