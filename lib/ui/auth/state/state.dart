import 'package:freezed_annotation/freezed_annotation.dart';
part 'state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = Loading;
  const factory AuthState.error(String error) = Error;

  const factory AuthState.loaded() = loaded;
}
