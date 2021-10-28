import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/training/training.dart';
import 'package:kwriting/src/infra/singletons/database.dart';
import 'package:kwriting/src/infra/singletons/file.dart';

class WordRepository implements IWordRepository {
  @override
  List<Word> getWords() {
    final languageCode = Database.storage.getString(DatabaseTag.language, defaultValue: Default.locale);
    return File.storage.getWords().map((wordModel) {
      wordModel.setLanguageCode(languageCode);
      return wordModel;
    }).toList();
  }

  @override
  List<Word> getWordsById(String id) {
    final languageCode = Database.storage.getString(DatabaseTag.language, defaultValue: Default.locale);
    return File.storage.getWordsById(id).map((wordModel) {
      wordModel.setLanguageCode(languageCode);
      return wordModel;
    }).toList();
  }

  @override
  List<Word> getWordsByQuery(String query) {
    final languageCode = Database.storage.getString(DatabaseTag.language, defaultValue: Default.locale);
    return File.storage.getWordsByQuery(query, languageCode);
  }

  @override
  Word getWord(String id) {
    final languageCode = Database.storage.getString(DatabaseTag.language, defaultValue: Default.locale);
    final word = File.storage.getWord(id)..setLanguageCode(languageCode);
    return word;
  }

  @override
  List<Word> getWordsForTraining(KanaType kanaType, int quantityOfWords) {
    final languageCode = Database.storage.getString(DatabaseTag.language, defaultValue: Default.locale);

    if (kanaType.isBoth) {
      final allWords = File.storage.getWords()..shuffle();

      final words = allWords.sublist(0, quantityOfWords);
      for (final word in words) {
        word.setLanguageCode(languageCode);
      }

      return words;
    }
    final wordsByKanaType = File.storage.getWordsByKanaType(kanaType)..shuffle();

    final words = wordsByKanaType.sublist(0, quantityOfWords);
    for (final word in words) {
      word.setLanguageCode(languageCode);
    }

    return words;
  }
}
