// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';

class WordViewModel extends Equatable {
  const WordViewModel({
    required this.id,
    required this.romaji,
    required this.kanaType,
    required this.imageUrl,
    required this.translate,
    required this.kanas,
    required this.correctCount,
    required this.wrongCount,
  });

  final String id;
  final String romaji;
  final KanaType kanaType;
  final String imageUrl;
  final String translate;
  final List<KanaViewModel> kanas;
  final int correctCount;
  final int wrongCount;

  @override
  List<Object?> get props => [id, romaji, kanaType, imageUrl, translate, kanas, correctCount, wrongCount];

  factory WordViewModel.fromWordModel(
    WordModel wordModel, {
    required String languageCode,
    required Map<String, int> correctWordCount,
    required Map<String, int> wrongWordCount,
    required Map<String, int> correctKanaCount,
    required Map<String, int> wrongKanaCount,
  }) {
    return WordViewModel(
      id: wordModel.id,
      romaji: wordModel.romaji,
      kanaType: wordModel.kanaType,
      imageUrl: wordModel.imageUrl,
      translate: wordModel.translate.toTranslateStr(languageCode),
      kanas: wordModel.kanas.map((kanaModel) {
        return KanaViewModel.fromKanaModel(kanaModel, correctKanaCount: correctKanaCount, wrongKanaCount: wrongKanaCount);
      }).toList(),
      correctCount: correctWordCount[wordModel.id] ?? 0,
      wrongCount: wrongWordCount[wordModel.id] ?? 0,
    );
  }
}
