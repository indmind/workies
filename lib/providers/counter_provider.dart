import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier {
  int value = 0;
  int weight = 0;

  void increment() {
    value++;
    notifyListeners();
  }

  void fatten() {
    weight = value * 2;
    notifyListeners();
  }
}
