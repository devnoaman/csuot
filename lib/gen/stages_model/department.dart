import 'dart:convert';

import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final String? id;
  final String? name;

  const Department({this.id, this.name});

  factory Department.fromMap(Map<String, dynamic> data) => Department(
        id: data['id'] as String?,
        name: data['name'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Department].
  factory Department.fromJson(String data) {
    return Department.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Department] to a JSON string.
  String toJson() => json.encode(toMap());

  Department copyWith({
    String? id,
    String? name,
  }) {
    return Department(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name];
}
