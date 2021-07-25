import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/settings.controller.dart';

class QuantityOfWordsProvider extends ChangeNotifier {
  QuantityOfWordsProvider(this._controller) {
    quantity = _controller.getQuantityOfWords();
    notifyListeners();
  }

  final SettingsController _controller;

  late int quantity;
  final int _step = 1;

  int get minWords => 5;
  int get maxWords => 20;
  int get divisions => (maxWords - minWords) ~/ _step;

  String get iconUrl => "lib/assets/icons/black/quantity_of_words.png";

  void updateQuantity(double value) {
    quantity = value.toInt();
    _controller.updateQuantityOfWords(quantity);
    notifyListeners();
  }
}
