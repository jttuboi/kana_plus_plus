import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/kana.entity.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';

class KanaModel extends Kana {
  const KanaModel({
    required int id,
    required String text,
    required String imageUrl,
    required KanaType type,
    String romaji = '',
    String romajiImageUrl = ImageUrl.empty,
    int numberStrokes = 0,
  }) : super(
          id: id,
          text: text,
          type: type,
          imageUrl: imageUrl,
          romaji: romaji,
          romajiImageUrl: romajiImageUrl,
          numberStrokes: numberStrokes,
        );

  const KanaModel.empty() : super.empty();

  factory KanaModel.fromMap(Map<String, dynamic> map) {
    return KanaModel(
      id: map[TKanas.kanaId] as int,
      text: map[TKanas.text] as String,
      type: KanaType.values[map[TKanas.type] as int],
      imageUrl: map[TKanas.imageUrl] as String,
      romaji: map.containsKey(TKanas.romaji) ? map[TKanas.romaji] as String : '',
      // TODO colocar links default para imagens vazias
      romajiImageUrl: map.containsKey(TKanas.romajiImageUrl) ? map[TKanas.romajiImageUrl] as String : ImageUrl.empty,
      numberStrokes: map.containsKey(TKanas.numberStrokes) ? map[TKanas.numberStrokes] as int : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TKanas.kanaId: id,
      TKanas.text: text,
      TKanas.type: type.index,
      TKanas.imageUrl: imageUrl,
      TKanas.romaji: romaji,
      TKanas.romajiImageUrl: romajiImageUrl,
      TKanas.numberStrokes: numberStrokes,
    };
  }
}
