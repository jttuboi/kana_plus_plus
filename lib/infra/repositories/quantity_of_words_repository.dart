import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';

class QuantityOfWordsRepository implements IQuantityOfWordsRepository {
  QuantityOfWordsRepository(this.database);

  IDatabase database;

  @override
  Future<int> getQuantityOfWords() async {
    await database.load(BoxTag.settings);
    return database.get(DatabaseTag.quantityOfWords, defaultValue: Default.minimumTrainingCards);
  }

  @override
  Future<void> updateQuantityOfWords(int quantityOfWords) async {
    await database.load(BoxTag.settings);
    await database.put(DatabaseTag.quantityOfWords, quantityOfWords);
  }
}
