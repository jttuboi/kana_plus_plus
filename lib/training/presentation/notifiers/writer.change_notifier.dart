import 'package:flutter/foundation.dart';
import 'package:kwriting/training/training.dart';

class WriterProvider extends ChangeNotifier {
  WriterProvider(this._controller);

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
