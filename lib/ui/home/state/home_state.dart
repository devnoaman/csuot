import 'package:csuot/gen/stages_model/stages_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = Loading;
  const factory HomeState.fetchNext() = FetchNext;

  const factory HomeState.loaded(List<StagesModel> stages) = Loaded;
  const factory HomeState.error(String error) = Error;
}
