import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/repositories/settings.interface.dart';

class QuantityOfWordsProvider extends ChangeNotifier {
  QuantityOfWordsProvider(this._repository) {
    quantity = _repository.getQuantityOfWords();
    notifyListeners();
  }

  final ISettingsRepository _repository;

  late int quantity;
  final int _step = 1;

  int get minWords => 5;
  int get maxWords => 20;
  int get divisions => (maxWords - minWords) ~/ _step;

  String get iconUrl => _repository.getQuantityOfWordsIconUrl();

  void updateQuantity(double value) {
    quantity = value.toInt();
    _repository.saveQuantityOfWords(quantity);
    notifyListeners();
  }
}
