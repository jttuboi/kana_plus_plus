import 'package:kana_plus_plus/src/data/models/kana.model.dart';
import 'package:kana_plus_plus/src/data/models/translate.model.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import "package:kana_plus_plus/src/domain/entities/kana_type.dart";
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';

class WordModel extends Word {
  const WordModel({
    required int id,
    required String word,
    required String imageUrl,
    String romaji = "",
    KanaType type = KanaType.none,
    TranslateModel translate = const TranslateModel.empty(),
    List<KanaModel> kanas = const [],
  }) : super(
          id: id,
          word: word,
          romaji: romaji,
          type: type,
          imageUrl: imageUrl,
          translate: translate,
          kanas: kanas,
        );

  const WordModel.empty() : super.empty();

  factory WordModel.fromMap(Map<String, dynamic> map,
      {List<Map<String, dynamic>>? kanasMap}) {
    return WordModel(
      id: map[TWords.wordId] as int,
      word: map[TWords.word] as String,
      imageUrl: map[TWords.imageUrl] as String,
      romaji:
          (map.containsKey(TWords.romaji)) ? map[TWords.romaji] as String : "",
      type: (map.containsKey(TWords.type))
          ? KanaType.values[map[TWords.type] as int]
          : KanaType.none,
      translate: (map.containsKey(TTranslates.code) ||
              map.containsKey(TTranslates.translate))
          ? TranslateModel.fromMap(map)
          : const TranslateModel.empty(),
      kanas: (kanasMap != null)
          ? kanasMap.map((kanaMap) => KanaModel.fromMap(kanaMap)).toList()
          : const [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TWords.wordId: id,
      TWords.word: word,
      TWords.imageUrl: imageUrl,
      TWords.romaji: romaji,
      TWords.type: type.index,
    };
  }
}
