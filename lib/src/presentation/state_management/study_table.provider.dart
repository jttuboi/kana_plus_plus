import 'package:flutter/widgets.dart';

class StudyTableProvider extends ChangeNotifier {
  bool showAllKana = false;

  void showKana() {
    showAllKana = true;
    notifyListeners();
  }
}
