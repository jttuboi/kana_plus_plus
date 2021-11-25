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
  });

  final String id;
  final String romaji;
  final KanaType kanaType;
  final String imageUrl;
  final String translate;
  final List<KanaViewModel> kanas;

  @override
  List<Object?> get props => [id, romaji, kanaType, imageUrl, translate, kanas];

  factory WordViewModel.fromWordModel(WordModel wordModel, {required String languageCode}) {
    return WordViewModel(
      id: wordModel.id,
      romaji: wordModel.romaji,
      kanaType: wordModel.kanaType,
      imageUrl: wordModel.imageUrl,
      translate: wordModel.translate.toTranslateStr(languageCode),
      kanas: wordModel.kanas.map((kanaModel) => KanaViewModel.fromKanaModel(kanaModel)).toList(),
    );
  }
}
