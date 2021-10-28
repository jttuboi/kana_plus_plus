import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';

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
