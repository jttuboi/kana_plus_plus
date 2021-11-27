// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';

class KanaViewModel extends Equatable {
  const KanaViewModel({
    required this.id,
    required this.kanaType,
    required this.romaji,
    required this.strokes,
  });

  final String id;
  final KanaType kanaType;
  final String romaji;
  final List<String> strokes;

  @override
  List<Object?> get props => [id, kanaType, romaji, strokes];

  factory KanaViewModel.fromKanaModel(KanaModel kanaModel) {
    return KanaViewModel(
      id: kanaModel.id,
      kanaType: kanaModel.kanaType,
      romaji: kanaModel.romaji,
      strokes: kanaModel.strokes,
    );
  }
}
