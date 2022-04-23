import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyErrorWidget extends HookConsumerWidget {
  final String error;
  const MyErrorWidget({
    Key? key,
    required this.error,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text(error),
    );
  }
}
