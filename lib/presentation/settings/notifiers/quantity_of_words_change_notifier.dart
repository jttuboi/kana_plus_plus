import 'package:flutter/foundation.dart';
import 'package:kwriting/domain/domain.dart';

class QuantityOfWordsChangeNotifier extends ChangeNotifier {
  QuantityOfWordsChangeNotifier(this.quantityOfWordsRepository, {this.mustPersist = true}) {
    quantityOfWordsRepository.getQuantityOfWords().then((quantityOfWords) {
      quantity = quantityOfWords;
      notifyListeners();
    });
  }

  final bool mustPersist;
  final IQuantityOfWordsRepository quantityOfWordsRepository;

  int quantity = Default.minimumTrainingCards;

  void updateQuantity(int quantityOfWords) {
    quantity = quantityOfWords;
    if (mustPersist) {
      quantityOfWordsRepository.updateQuantityOfWords(quantityOfWords);
    }
    notifyListeners();
  }
}
