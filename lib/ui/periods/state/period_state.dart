import 'package:csuot/models/periods_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'period_state.freezed.dart';

@freezed
class PeriodState with _$PeriodState {
  const factory PeriodState.initial() = _Initial;
  const factory PeriodState.loading() = Loading;

  const factory PeriodState.loaded(List<PeriodsModel> stages) = Loaded;
  const factory PeriodState.error(String error) = Error;
}
