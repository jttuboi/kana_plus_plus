import 'package:flutter/foundation.dart';
import 'package:kwriting/features/training/training.dart';

class WriterChangeNotifier extends ChangeNotifier {
  WriterChangeNotifier(this._controller);

  final WriterController _controller;

  bool isDisabled = false;

  void updateWriter(KanaToWrite kanaToWrite) {
    _controller.updateWriter(kanaToWrite);
    notifyListeners();
  }

  void enable() {
    isDisabled = false;
    notifyListeners();
  }

  void disable() {
    isDisabled = true;
    notifyListeners();
  }
}
