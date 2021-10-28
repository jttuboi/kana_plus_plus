import 'package:flutter/foundation.dart';
import 'package:kwriting/settings/settings.dart';

class QuantityOfWordsChangeNotifier extends ChangeNotifier {
  QuantityOfWordsChangeNotifier(this._controller);

  final SettingsController _controller;

  int get quantity => _controller.quantityOfWords;

  void updateQuantity(double value) {
    _controller.updateQuantityOfWords(value.toInt());
    notifyListeners();
  }
}
