import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'department.dart';

class Branch extends Equatable {
  final String? id;
  final String? name;
  final Department? department;

  const Branch({this.id, this.name, this.department});

  factory Branch.fromMap(Map<String, dynamic> data) => Branch(
        id: data['id'] as String?,
        name: data['name'] as String?,
        department: data['department'] == null
            ? null
            : Department.fromMap(data['department'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'department': department?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Branch].
  factory Branch.fromJson(String data) {
    return Branch.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Branch] to a JSON string.
  String toJson() => json.encode(toMap());

  Branch copyWith({
    String? id,
    String? name,
    Department? department,
  }) {
    return Branch(
      id: id ?? this.id,
      name: name ?? this.name,
      department: department ?? this.department,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, name, department];
}
