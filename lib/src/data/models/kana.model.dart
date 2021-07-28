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
      id: map[Column.kanaId] as int,
      kana: map[Column.kana] as String,
      imageUrl: map[Column.imageUrl] as String,
      romaji: map[Column.romaji] as String,
      romajiImageUrl: map[Column.romajiImageUrl] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Column.kanaId: id,
      Column.kana: kana,
      Column.imageUrl: imageUrl,
      Column.romaji: romaji,
      Column.romajiImageUrl: romajiImageUrl,
    };
  }

  @override
  String toString() {
    return "Kana($id, $kana, $imageUrl, $romaji, $romajiImageUrl)";
  }
}
