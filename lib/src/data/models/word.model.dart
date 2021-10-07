import 'package:kwriting/src/data/datasources/image_url.storage.dart';
import 'package:kwriting/src/data/utils/consts.dart';
import 'package:kwriting/src/domain/entities/word.dart';
import 'package:kwriting/src/domain/utils/kana_type.dart';

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
      imageUrl: ImageUrl.imageFolder + (json[TWords.imageUrl] as String),
    );
  }
}
