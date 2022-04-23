import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'branch.dart';

class StagesModel extends Equatable {
  final String? name;
  final String? shift;
  final int? level;
  final String? branchId;
  final String? id;
  final Branch? branch;

  const StagesModel({
    this.name,
    this.shift,
    this.level,
    this.branchId,
    this.id,
    this.branch,
  });

  factory StagesModel.fromMap(Map<String, dynamic> data) => StagesModel(
        name: data['name'] as String?,
        shift: data['shift'] as String?,
        level: data['level'] as int?,
        branchId: data['branch_id'] as String?,
        id: data['id'] as String?,
        branch: data['branch'] == null
            ? null
            : Branch.fromMap(data['branch'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'shift': shift,
        'level': level,
        'branch_id': branchId,
        'id': id,
        'branch': branch?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [StagesModel].
  factory StagesModel.fromJson(String data) {
    return StagesModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [StagesModel] to a JSON string.
  String toJson() => json.encode(toMap());

  StagesModel copyWith({
    String? name,
    String? shift,
    int? level,
    String? branchId,
    String? id,
    Branch? branch,
  }) {
    return StagesModel(
      name: name ?? this.name,
      shift: shift ?? this.shift,
      level: level ?? this.level,
      branchId: branchId ?? this.branchId,
      id: id ?? this.id,
      branch: branch ?? this.branch,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [name, shift, level, branchId, id, branch];
}
