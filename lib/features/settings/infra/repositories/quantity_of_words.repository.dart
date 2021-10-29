import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class QuantityOfWordsRepository implements IQuantityOfWordsRepository {
  @override
  int getQuantityOfWords() {
    return Database.storage.getInt(DatabaseTag.quantityOfWords, defaultValue: Default.minimumTrainingCards);
  }

  @override
  void setQuantityOfWords(int value) {
    Database.storage.setInt(DatabaseTag.quantityOfWords, value);
  }
}
