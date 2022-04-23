import 'package:csuot/data/constants.dart';
import 'package:csuot/ui/periods/periods_provider.dart';
import 'package:csuot/ui/widgets/error.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Periods extends HookConsumerWidget {
  const Periods({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var periods = ref.watch(periodsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Periods'),
      ),
      body: periods.maybeWhen(
          initial: () {
            return const LinearProgressIndicator();
          },
          loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
          error: (error) => MyErrorWidget(error: error),
          loaded: (data) {
            return ListView(children: [
              ...data.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 3,
                            color: primaryColor(context).withOpacity(.2),
                            spreadRadius: 0.3,
                            offset: const Offset(
                              .3,
                              .5,
                            ),
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
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
                            ],
                          ),
                          const Divider(),
                          Row(
                            children: [
                              const Icon(Icons.timelapse),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(e.startTime.toString())
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.timelapse),
                              const SizedBox(
                                width: 16,
                              ),
                              Text(e.endTime.toString())
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
              const SizedBox(
                height: 140,
              )
            ]);
          },
          orElse: () => const MyErrorWidget(error: 'Something went wrong')),
    );
  }
}
