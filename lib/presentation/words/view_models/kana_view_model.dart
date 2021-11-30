// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';

class KanaViewModel extends Equatable {
  const KanaViewModel({
    required this.id,
    required this.kanaType,
    required this.romaji,
    required this.strokes,
    required this.correctCount,
    required this.wrongCount,
  });

  final String id;
  final KanaType kanaType;
  final String romaji;
  final List<String> strokes;
  final int correctCount;
  final int wrongCount;

  @override
  List<Object?> get props => [id, kanaType, romaji, strokes, correctCount, wrongCount];

  factory KanaViewModel.fromKanaModel(
    KanaModel kanaModel, {
    required Map<String, int> correctKanaCount,
    required Map<String, int> wrongKanaCount,
  }) {
    return KanaViewModel(
      id: kanaModel.id,
      kanaType: kanaModel.kanaType,
      romaji: kanaModel.romaji,
      strokes: kanaModel.strokes,
      correctCount: correctKanaCount[kanaModel.id] ?? 0,
      wrongCount: wrongKanaCount[kanaModel.id] ?? 0,
    );
  }
}
