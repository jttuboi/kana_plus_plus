import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/kana.entity.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_type.dart';

class KanaModel extends Kana {
  const KanaModel({
    required String id,
    required String imageUrl,
    required KanaType type,
    String romaji = '',
    int strokesQuantity = 0,
  }) : super(
          id: id,
          type: type,
          imageUrl: imageUrl,
          romaji: romaji,
          strokesQuantity: strokesQuantity,
        );

  const KanaModel.empty() : super.empty();

  factory KanaModel.fromJson(Map<String, dynamic> json) {
    return KanaModel(
      id: json[TKanas.id] as String,
      type: toKanaType(json[TKanas.type] as String),
      imageUrl: ImageUrl.imageFolder + (json[TKanas.imageUrl] as String),
      romaji: json[TKanas.romaji] as String,
      strokesQuantity: json[TKanas.strokesQuantity] as int,
    );
  }
}
