import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/word.dart';
import 'package:kana_plus_plus/src/domain/utils/kana_type.dart';

class WordModel extends Word {
  WordModel({
    required String id,
    required String imageUrl,
    String romaji = '',
    KanaType type = KanaType.none,
  }) : super(
          id: id,
          romaji: romaji,
          type: type,
          imageUrl: imageUrl,
        );

  WordModel.empty() : super.empty();

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json[TWords.id] as String,
      romaji: json[TWords.romaji] as String,
      type: toKanaType(json[TWords.type] as String),
      imageUrl: ImageUrl.imageTestFolder + (json[TWords.imageUrl] as String),
    );
  }
}
