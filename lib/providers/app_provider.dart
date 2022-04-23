import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final app = ChangeNotifierProvider.autoDispose((ref) {
  return AppState();
});

class AppState extends ChangeNotifier {
  final GlobalKey<ScaffoldState> key = GlobalKey();

  int _currentTap = 0;
  int get currentTap => _currentTap;
  onTap(int val) {
    _currentTap = val;
    notifyListeners();
  }
}
