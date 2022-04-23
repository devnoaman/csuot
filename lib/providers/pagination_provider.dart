import 'dart:developer';

import 'package:csuot/data/storage.dart';
import 'package:csuot/models/pagination_model.dart';
import 'package:csuot/ui/home/home_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/*
! TODO UPDATE THIS
      this provider [MUST] be replaced because when we navigate to
      the[PeriodsScreen] we lose the count of paginations.
      
      -> ---- MAKE USE OF SharedPrefrences -----

*/
final paginationProvider =
    StateNotifierProvider<Pagination, PaginationModel>((ref) {
  return Pagination(ref);
});

class Pagination extends StateNotifier<PaginationModel> {
  StateNotifierProviderRef<Pagination, PaginationModel> ref;
  Pagination(this.ref) : super(PaginationModel(1, 1)) {
    log("init");
    init();
  }
  void increment() {
    state = state.copyWith(current: state.current + 1);
  }

  init() async {
    var i = await getPagination() ?? 1;
    state = state.copyWith(size: i);
  }

  void set(int val) {
    state = state.copyWith(size: val);
  }

  void setCurrent(int val) {
    state = state.copyWith(current: val);
    // ref.refresh(homeProvider);
    ref.refresh(listProvider);
  }
}
