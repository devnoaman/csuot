import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String? accessToken;
  final String? tokenType;

  const AuthResponse({this.accessToken, this.tokenType});

  factory AuthResponse.fromMap(Map<String, dynamic> data) => AuthResponse(
        accessToken: data['access_token'] as String?,
        tokenType: data['token_type'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'access_token': accessToken,
        'token_type': tokenType,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AuthResponse].
  factory AuthResponse.fromJson(String data) {
    return AuthResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AuthResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [accessToken, tokenType];
}
