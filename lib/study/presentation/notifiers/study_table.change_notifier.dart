import 'package:flutter/widgets.dart';

class StudyTableChangeNotifier extends ChangeNotifier {
  bool showAllKana = false;

  void showKana() {
    showAllKana = true;
    notifyListeners();
  }
}
