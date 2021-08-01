import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';

class QuantityOfWordsProvider extends ChangeNotifier {
  QuantityOfWordsProvider(this._controller);

  final SettingsController _controller;

  int get quantity => _controller.getQuantityOfWords();

  double get minWords => _controller.getMinimumQuantityOfWords();

  double get maxWords => _controller.getMaximumQuantityOfWords();

  String get iconUrl => _controller.getQuantityOfWordsIconUrl();

  void updateQuantity(double value) {
    _controller.updateQuantityOfWords(value.toInt());
    notifyListeners();
  }
}
