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

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map[Column.wordId] as int,
      word: map[Column.word] as String,
      imageUrl: map[Column.imageUrl] as String,
      romaji:
          (map.containsKey(Column.romaji)) ? map[Column.romaji] as String : "",
      type: (map.containsKey(Column.type))
          ? KanaType.values[map[Column.type] as int]
          : KanaType.none,
      translate: TranslateModel.fromMap(map),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Column.wordId: id,
      Column.word: word,
      Column.imageUrl: imageUrl,
      Column.romaji: romaji,
      Column.type: type.index,
    };
  }

  @override
  String toString() {
    return "Word($id, $word, $imageUrl, $romaji, $type, $translate, $kanas)";
  }
}
