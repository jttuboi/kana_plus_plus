import 'package:flutter/foundation.dart';
import 'package:kwriting/training/domain/entities/kana_to_writer.dart';
import 'package:kwriting/training/domain/use_cases/writer.controller.dart';

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
