import 'dart:async';
import 'dart:developer';

import 'package:csuot/data/storage.dart';
import 'package:csuot/models/pagination_model.dart';
import 'package:csuot/providers/pagination_provider.dart';
import 'package:csuot/ui/auth/auth_router.dart';
import 'package:csuot/ui/periods/periods_router.dart';
import 'package:csuot/ui/widgets/error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

import 'package:csuot/data/constants.dart';
import 'package:csuot/gen/stages_model/stages_model.dart';
import 'package:csuot/providers/token_provider.dart';
import 'package:csuot/ui/home/home_provider.dart';

class Home extends HookConsumerWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('home');

    var list = ref.watch(listProvider);
    PaginationModel pag = ref.watch(paginationProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Stages'),
        actions: [
          IconButton(
            icon: Icon(Icons.time_to_leave),
            onPressed: () {
              pushNamed(context, PeriodsRouter.periods);
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              removeToken();

              gotoNamed(context, AuthRouter.login);
            },
          ),
        ],
        bottom: PreferredSize(
          child: SizedBox(
            width: getWidth(context),
            height: 45,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          (pag.current != i + 1)
                              ? {
                                  ref
                                      .watch(paginationProvider.notifier)
                                      .setCurrent(i + 1)
                                }
                              : {};
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: pag.current == i + 1
                                  ? Colors.white
                                  : Colors.transparent),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Center(
                              child: Text(
                                (i + 1).toString(),
                                style: const TextStyle(fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                separatorBuilder: (context, i) => SizedBox(),
                itemCount: (pag.size / 5).ceil()),
          ),
          preferredSize: Size(getWidth(context), 55),
        ),
      ),
      body: list.maybeWhen(
          initial: () {
            // ref.listen(listProvider, (previous, next) {});
            // ref.watch(listProvider.notifier).fetch(pag.current, 15);

            return LinearProgressIndicator();
          },
          loading: () => Center(
                child: CircularProgressIndicator(),
              ),
          error: (error) => MyErrorWidget(error: error),
          loaded: (data) {
            print(ref.watch(listProvider.notifier).state);
            return ListView(children: [
              ...data.map((e) {
                return StageCard(
                  e: e,
                );
              }).toList(),
              const SizedBox(
                height: 140,
                // child: ,
              )
            ]);
            //   ),
            // ),
            // );
          },
          orElse: () => Text('else')),
    );
  }
}

class StageCard extends HookConsumerWidget {
  final StagesModel e;
  const StageCard({
    Key? key,
    required this.e,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: primaryColor(context).withOpacity(.2),
            spreadRadius: 0.3,
            offset: Offset(
              .3,
              .5,
            ),
          )
        ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      e.name.toString(),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor(context).withOpacity(.3)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        e.level.toString(),
                      ),
                    ),
                  )
                ],
              ),
              Divider(),
              Row(
                children: [
                  Icon(Icons.school_outlined),
                  SizedBox(
                    width: 16,
                  ),
                  Text(e.branch!.department!.name!.toString())
                ],
              ),
              Row(
                children: [
                  Icon(Icons.construction),
                  SizedBox(
                    width: 16,
                  ),
                  Text(e.branch!.name!.toString())
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
