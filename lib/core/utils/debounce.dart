import 'package:flutter/foundation.dart';
import 'dart:async';

class Debounce {
  static Debounce? _singleton;

  Debounce._();

  factory Debounce() {
    _singleton ??= Debounce._();
    return _singleton!;
  }

  static Debounce get instance => Debounce();

  VoidCallback? action;
  Timer? _timer;
  bool isBusy = false;

  final delay = 300;

  runAfter({required VoidCallback action, int? rate}) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: rate ?? delay), action);
  }

  runBefore({required VoidCallback action, int? rate}) {
    try {
      if (!isBusy) {
        isBusy = true;
        Timer(Duration(milliseconds: rate ?? delay), () => isBusy = false);
        action();
      }
    } catch (e) {}
  }
}
