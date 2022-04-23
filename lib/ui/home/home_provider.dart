import 'dart:convert';
import 'dart:developer';

import 'package:csuot/data/constants.dart';
import 'package:csuot/data/storage.dart';
import 'package:csuot/gen/stages_model/stages_model.dart';
import 'package:csuot/http.dart';
import 'package:csuot/models/pagination_model.dart';
import 'package:csuot/providers/container.dart';
import 'package:csuot/providers/pagination_provider.dart';
import 'package:csuot/ui/auth/state/state.dart';
import 'package:csuot/ui/home/state/home_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final homeProvider = StateProvider((ref) {
//   return HomeState.initial();
// });

final listProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(ref);
});

class HomeNotifier extends StateNotifier<HomeState> {
  StateNotifierProviderRef<HomeNotifier, HomeState> ref;
  HomeNotifier(this.ref) : super(HomeState.initial()) {
    final page = ref.read(paginationProvider).current;
    // print(page.toString());
    fetch(page, 5);
    // Future.delayed(Duration(milliseconds: 1000)).then((value) {
    //   log(state.toString());
    // });
  }
  Future<int> getPag() async {
    return await getPagination();
  }

  fetch(page, limit) async {
    await getPag();

    log('home fetch hitted');
    // state = const HomeState.loading();
    try {
      await dio
          .get(
        stagesEndPoint,
        queryParameters: {"page": page, "per_page": limit},
        options: Options(
          // sendTimeout: 1000,
          contentType: Headers.formUrlEncodedContentType,
        ),
      )
          .then((value) async {
        if (value.statusCode == 200) {
          final List resList = await value.data['results'];

          // ref.read(homeProvider.state).update(
          //   (state) {
          //     return const HomeState.loaded();
          //   },
          // );
          savePagination(value.data['count']);
          // ref.watch(paginationProvider.notifier).set();

          final List<StagesModel> m = resList.map((e) {
            return StagesModel.fromJson(jsonEncode(e));
          }).toList();
          state = HomeState.loaded(m);

          // state = [...m];
        }
        log('loin');
      });
    } catch (e) {
      state = HomeState.error(e.toString());
      log(e.toString());
    }
  }
}
