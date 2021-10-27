import 'package:flutter/foundation.dart';
import 'package:kwriting/src/domain/controllers/settings.controller.dart';

class QuantityOfWordsProvider extends ChangeNotifier {
  QuantityOfWordsProvider(this._controller);

  final SettingsController _controller;

  int get quantity => _controller.quantityOfWords;

  void updateQuantity(double value) {
    _controller.updateQuantityOfWords(value.toInt());
    notifyListeners();
  }
}
