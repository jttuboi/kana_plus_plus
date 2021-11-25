import 'package:flutter/foundation.dart';

class TrainingWordChangeNotifier extends ChangeNotifier {
  TrainingWordChangeNotifier();

  void updateState() {
    notifyListeners();
  }
}
