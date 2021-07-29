import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/kana.entity.dart';

class KanaModel extends Kana {
  const KanaModel({
    required int id,
    required String kana,
    required String imageUrl,
    String romaji = "",
    String romajiImageUrl = "",
  }) : super(
          id: id,
          kana: kana,
          imageUrl: imageUrl,
          romaji: romaji,
          romajiImageUrl: romajiImageUrl,
        );

  const KanaModel.empty() : super.empty();

  factory KanaModel.fromMap(Map<String, dynamic> map) {
    return KanaModel(
      id: map[TKanas.kanaId] as int,
      kana: map[TKanas.kana] as String,
      imageUrl: map[TKanas.imageUrl] as String,
      romaji: map[TKanas.romaji] as String,
      romajiImageUrl: map[TKanas.romajiImageUrl] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TKanas.kanaId: id,
      TKanas.kana: kana,
      TKanas.imageUrl: imageUrl,
      TKanas.romaji: romaji,
      TKanas.romajiImageUrl: romajiImageUrl,
    };
  }

  @override
  String toString() {
    return "Kana($id, $kana, $imageUrl, $romaji, $romajiImageUrl)";
  }
}
