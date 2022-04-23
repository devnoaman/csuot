import 'dart:convert';
import 'dart:developer';

import 'package:csuot/data/constants.dart';
import 'package:csuot/data/storage.dart';
import 'package:csuot/gen/auth_response.dart';
import 'package:csuot/gen/stages_model/stages_model.dart';
import 'package:csuot/http.dart';
import 'package:csuot/models/periods_model.dart';

import 'package:csuot/providers/pagination_provider.dart';

import 'package:csuot/ui/home/state/home_state.dart';
import 'package:csuot/ui/periods/state/period_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final periodsProvider =
    StateNotifierProvider<PeriodNotifier, PeriodState>((ref) {
  return PeriodNotifier(ref);
});

class PeriodNotifier extends StateNotifier<PeriodState> {
  StateNotifierProviderRef<PeriodNotifier, PeriodState> ref;
  PeriodNotifier(this.ref) : super(PeriodState.initial()) {
    // final page = ref.read(paginationProvider).current;
    // print(page.toString());
    fetch(1, 5);
    // Future.delayed(Duration(milliseconds: 1000)).then((value) {
    //   log(state.toString());
    // });
  }
  fetch(page, limit) async {
    log('period fetch hitted');
    var tokenWord = await getToken();
    print(tokenWord);
    AuthResponse res = AuthResponse.fromJson(tokenWord);
    // state = const PeriodState.loading();
    try {
      await dio
          .get(
        periodsEndPoint,
        queryParameters: {"page": page, "per_page": limit},
        options: Options(
            // sendTimeout: 1000,

            headers: {"Authorization": "${res.tokenType} ${res.accessToken}"}
            // contentType: Headers.formUrlEncodedContentType,
            ),
      )
          .then((value) async {
        if (value.statusCode == 200) {
          final List resList = await value.data['results'];

          // ref.read(homeProvider.state).update(
          //   (state) {
          //     return const PeriodState.loaded();
          //   },
          // );
          ref.watch(paginationProvider.notifier).set(value.data['count']);

          final List<PeriodsModel> m = resList.map((e) {
            return PeriodsModel.fromJson(jsonEncode(e));
          }).toList();
          state = PeriodState.loaded(m);

          // state = [...m];
        }

        log('loin');
      });
    } catch (e) {
      state = PeriodState.error(e.toString());
      log(e.toString());
    }
  }
}
