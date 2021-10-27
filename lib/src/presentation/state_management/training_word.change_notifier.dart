import 'package:flutter/foundation.dart';

class TrainingWordProvider extends ChangeNotifier {
  TrainingWordProvider();

  void updateState() {
    notifyListeners();
  }
}
