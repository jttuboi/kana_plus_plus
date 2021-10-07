import 'package:kwriting/src/data/singletons/database.dart';
import 'package:kwriting/src/data/utils/consts.dart';
import 'package:kwriting/src/domain/repositories/quantity_of_words.interface.repository.dart';
import 'package:kwriting/src/domain/utils/consts.dart';

class QuantityOfWordsRepository implements IQuantityOfWordsRepository {
  @override
  int getQuantityOfWords() {
    return Database.getInt(DatabaseTag.quantityOfWords, defaultValue: Default.minimumTrainingCards);
  }

  @override
  void setQuantityOfWords(int value) {
    Database.setInt(DatabaseTag.quantityOfWords, value);
  }
}
