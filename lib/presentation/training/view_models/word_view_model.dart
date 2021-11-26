// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

class WordViewModel extends Equatable {
  const WordViewModel({
    required this.id,
    required this.imageUrl,
    required this.translate,
    required this.kanas,
  });

  final String id;
  final String imageUrl;
  final String translate;
  final List<KanaViewModel> kanas;

  @override
  List<Object?> get props => [id, imageUrl, translate, kanas];

  factory WordViewModel.fromWordModel(WordModel wordModel, {required String languageCode}) {
    return WordViewModel(
      id: wordModel.id,
      imageUrl: wordModel.imageUrl,
      translate: wordModel.translate.toTranslateStr(languageCode),
      kanas: wordModel.kanas.asMap().entries.map((entry) => KanaViewModel.fromKanaModel(entry.value, entry.key == 0)).toList(),
    );
  }

  WordViewModel copyWith({
    String? id,
    String? imageUrl,
    String? translate,
    List<KanaViewModel>? kanas,
  }) {
    return WordViewModel(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      translate: translate ?? this.translate,
      kanas: kanas ?? this.kanas,
    );
  }

  WordStats toWordStats() {
    const isIncorrect = false;
    const notFoundIncorrect = -1;

    final kanaStats = kanas.map((kanaViewModel) => kanaViewModel.toKanaStats()).toList();
    final correct = kanaStats.indexWhere((kanaStats) => kanaStats.correct == isIncorrect) == notFoundIncorrect;
    return WordStats(
      id: id,
      correct: correct,
      kanas: kanaStats,
    );
  }
}
