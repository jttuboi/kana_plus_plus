import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kana_plus_plus/src/data/datasources/file.interface.storage.dart';
import 'package:kana_plus_plus/src/data/models/kana.model.dart';
import 'package:kana_plus_plus/src/data/models/translate.model.dart';
import 'package:kana_plus_plus/src/data/models/word.model.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/support/word_to_kana_converter.dart';
import 'package:kana_plus_plus/src/domain/utils/kana_type.dart';

class JsonStorage implements IFileStorage {
  final data = JsonData();

  @override
  Future<void> init() async {
    await rootBundle.loadString(FileUrl.translates).then((response) {
      final jsonFile = json.decode(response) as List<dynamic>;
      for (final jsonData in jsonFile) {
        final model = TranslateModel.fromJson(jsonData as Map<String, dynamic>);
        data.translates[model.id] = model;
      }
    });
    await rootBundle.loadString(FileUrl.kanas).then((response) {
      final jsonFile = json.decode(response) as List<dynamic>;
      for (final jsonData in jsonFile) {
        final model = KanaModel.fromJson(jsonData as Map<String, dynamic>);
        data.kanas[model.id] = model;
      }
    });
    await rootBundle.loadString(FileUrl.words).then((response) {
      final jsonFile = json.decode(response) as List<dynamic>;
      for (final jsonData in jsonFile) {
        final model = WordModel.fromJson(jsonData as Map<String, dynamic>);
        data.words[model.id] = model;
      }
    });

    final converter = WordToKanaConverter();

    data.words.forEach((wordId, wordModel) {
      wordModel.setTranslate(data.translates[wordId]!);
      wordModel.kanas = converter.convert(wordId, data.kanas);
    });
  }

  @override
  List<WordModel> getWords() {
    return data.words.entries.map((e) => e.value).toList();
  }

  @override
  List<WordModel> getWordsById(String id) {
    return [data.words[id]!];
  }

  @override
  List<WordModel> getWordsByQuery(String query, String languageCode) {
    final words = <WordModel>[];
    data.words.forEach((id, word) {
      word.setLanguageCode(languageCode);
      if (word.id.contains(query) || word.romaji.contains(query) || word.translate.contains(query)) {
        words.add(word);
      }
    });
    return words;
  }

  @override
  WordModel getWord(String id) {
    return data.words[id]!;
  }

  @override
  List<WordModel> getWordsByKanaType(KanaType kanaType) {
    return data.words.entries.where((entry) => entry.value.type == kanaType).map((entry) => entry.value).toList();
  }
}

class JsonData {
  final Map<String, WordModel> words = <String, WordModel>{};
  final Map<String, KanaModel> kanas = <String, KanaModel>{};
  final Map<String, TranslateModel> translates = <String, TranslateModel>{};
}
