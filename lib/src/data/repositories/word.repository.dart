import 'package:kwriting/src/data/singletons/database.dart';
import 'package:kwriting/src/data/singletons/file.dart';
import 'package:kwriting/src/data/utils/consts.dart';
import 'package:kwriting/src/domain/entities/word.dart';
import 'package:kwriting/src/domain/repositories/word.interface.repository.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/domain/utils/kana_type.dart';

class WordRepository implements IWordRepository {
  @override
  List<Word> getWords() {
    final languageCode = Database.getString(DatabaseTag.language, defaultValue: Default.locale);
    return File.getWords().map((wordModel) {
      wordModel.setLanguageCode(languageCode);
      return wordModel;
    }).toList();
  }

  @override
  List<Word> getWordsById(String id) {
    final languageCode = Database.getString(DatabaseTag.language, defaultValue: Default.locale);
    return File.getWordsById(id).map((wordModel) {
      wordModel.setLanguageCode(languageCode);
      return wordModel;
    }).toList();
  }

  @override
  List<Word> getWordsByQuery(String query) {
    final languageCode = Database.getString(DatabaseTag.language, defaultValue: Default.locale);
    return File.getWordsByQuery(query, languageCode);
  }

  @override
  Word getWord(String id) {
    final languageCode = Database.getString(DatabaseTag.language, defaultValue: Default.locale);
    final word = File.getWord(id);
    word.setLanguageCode(languageCode);
    return word;
  }

  @override
  List<Word> getWordsForTraining(KanaType kanaType, int quantityOfWords) {
    final languageCode = Database.getString(DatabaseTag.language, defaultValue: Default.locale);

    if (kanaType.isBoth) {
      final allWords = File.getWords();
      allWords.shuffle();

      final words = allWords.sublist(0, quantityOfWords);
      for (final word in words) {
        word.setLanguageCode(languageCode);
      }

      return words;
    }
    final wordsByKanaType = File.getWordsByKanaType(kanaType);
    wordsByKanaType.shuffle();

    final words = wordsByKanaType.sublist(0, quantityOfWords);
    for (final word in words) {
      word.setLanguageCode(languageCode);
    }

    return words;
  }
}
