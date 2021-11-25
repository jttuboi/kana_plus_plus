// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';

class Word extends Equatable {
  const Word({
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
  final List<Kana> kanas;

  @override
  List<Object?> get props => [id, romaji, kanaType, imageUrl, translate, kanas];

  factory Word.fromWordModel(WordModel wordModel, {required String languageCode}) {
    return Word(
      id: wordModel.id,
      romaji: wordModel.romaji,
      kanaType: wordModel.kanaType,
      imageUrl: wordModel.imageUrl,
      translate: wordModel.translate.toTranslateStr(languageCode),
      kanas: wordModel.kanas.map((kanaModel) => Kana.fromKanaModel(kanaModel)).toList(),
    );
  }
}
