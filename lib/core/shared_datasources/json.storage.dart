import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:kwriting/core/core.dart';

class JsonStorage implements IFileStorage {
  final data = JsonData();

  @override
  Future<void> initialize() async {
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

    final words = <String, WordModel>{};
    await rootBundle.loadString(FileUrl.words).then((response) {
      final jsonFile = json.decode(response) as List<dynamic>;
      for (final jsonData in jsonFile) {
        final model = WordModel.fromJson(jsonData as Map<String, dynamic>);
        words[model.id] = model;
      }
    });

    final converter = WordToKanaConverter();

    words.forEach((wordId, wordModel) {
      data.words[wordModel.id] = wordModel.copyWith(
        translate: data.translates[wordId],
        kanas: converter.convert(wordId, data.kanas),
      );
    });
  }

  @override
  List<WordModel> getAllWords() {
    return data.words.values.toList();
  }
}

class JsonData {
  final Map<String, WordModel> words = <String, WordModel>{};
  final Map<String, KanaModel> kanas = <String, KanaModel>{};
  final Map<String, TranslateModel> translates = <String, TranslateModel>{};
}
