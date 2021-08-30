import 'package:kana_plus_plus/src/data/singletons/cache.dart';
import 'package:kana_plus_plus/src/data/singletons/file.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/word.interface.repository.dart';

class WordRepository implements IWordRepository {
  @override
  List<Word> getWords() {
    final languageCode = Cache.getString(SettingsPref.language, defaultValue: Default.locale);
    return File.getWords().map((wordModel) {
      wordModel.setLanguageCode(languageCode);
      return wordModel;
    }).toList();
  }

  @override
  List<Word> getWordsById(String id) {
    final languageCode = Cache.getString(SettingsPref.language, defaultValue: Default.locale);
    return File.getWordsById(id).map((wordModel) {
      wordModel.setLanguageCode(languageCode);
      return wordModel;
    }).toList();
  }

  @override
  List<Word> getWordsByQuery(String query) {
    final languageCode = Cache.getString(SettingsPref.language, defaultValue: Default.locale);
    return File.getWordsByQuery(query, languageCode);
  }

  @override
  Word getWord(String id) {
    final languageCode = Cache.getString(SettingsPref.language, defaultValue: Default.locale);
    final word = File.getWord(id);
    word.setLanguageCode(languageCode);
    return word;
  }

  @override
  List<Word> getWordsByIds(List<String> ids) {
    return File.getWordsByIds(ids);
  }
}
