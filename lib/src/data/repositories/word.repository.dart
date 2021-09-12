import 'package:kana_plus_plus/src/data/singletons/database.dart';
import 'package:kana_plus_plus/src/data/singletons/file.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/domain/core/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/word.dart';
import 'package:kana_plus_plus/src/domain/repositories/word.interface.repository.dart';

class WordRepository implements IWordRepository {
  @override
  List<Word> getWords() {
    final languageCode = Database.getString(SettingsPref.language, defaultValue: Default.locale);
    return File.getWords().map((wordModel) {
      wordModel.setLanguageCode(languageCode);
      return wordModel;
    }).toList();
  }

  @override
  List<Word> getWordsById(String id) {
    final languageCode = Database.getString(SettingsPref.language, defaultValue: Default.locale);
    return File.getWordsById(id).map((wordModel) {
      wordModel.setLanguageCode(languageCode);
      return wordModel;
    }).toList();
  }

  @override
  List<Word> getWordsByQuery(String query) {
    final languageCode = Database.getString(SettingsPref.language, defaultValue: Default.locale);
    return File.getWordsByQuery(query, languageCode);
  }

  @override
  Word getWord(String id) {
    final languageCode = Database.getString(SettingsPref.language, defaultValue: Default.locale);
    final word = File.getWord(id);
    word.setLanguageCode(languageCode);
    return word;
  }

  @override
  List<Word> getWordsForTraining(KanaType kanaType, int quantityOfWords) {
    if (kanaType.isBoth) {
      final allWords = File.getWords();
      allWords.shuffle();
      return allWords.sublist(0, quantityOfWords);
    }
    final wordsByKanaType = File.getWordsByKanaType(kanaType);
    wordsByKanaType.shuffle();
    return wordsByKanaType.sublist(0, quantityOfWords);
  }
}
