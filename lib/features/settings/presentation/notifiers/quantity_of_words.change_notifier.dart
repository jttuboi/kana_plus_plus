import 'package:flutter/foundation.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class QuantityOfWordsChangeNotifier extends ChangeNotifier {
  QuantityOfWordsChangeNotifier(IQuantityOfWordsRepository quantityOfWordsRepository, {this.mustPersist = true}) {
    _getQuantityOfWords = GetQuantityOfWords(quantityOfWordsRepository);
    _updateQuantityOfWords = UpdateQuantityOfWords(quantityOfWordsRepository);

    _getQuantityOfWords(NoParams()).then((quantityOfWords) {
      quantity = quantityOfWords;
      notifyListeners();
    });
  }

  final bool mustPersist;
  late final GetQuantityOfWords _getQuantityOfWords;
  late final UpdateQuantityOfWords _updateQuantityOfWords;

  int quantity = Default.minimumTrainingCards;

  void updateQuantity(int quantityOfWords) {
    quantity = quantityOfWords;
    if (mustPersist) {
      _updateQuantityOfWords(QuantityOfWordsParams(quantityOfWords));
    }
    notifyListeners();
  }
}
