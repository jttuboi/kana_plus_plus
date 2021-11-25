import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

class Kana2Model extends Kana {
  const Kana2Model({
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

  const Kana2Model.empty() : super.empty();

  factory Kana2Model.fromJson(Map<String, dynamic> json) {
    return Kana2Model(
      id: json[TKanas.id] as String,
      type: toKanaType(json[TKanas.type] as String),
      imageUrl: ImageUrl.imageFolder + (json[TKanas.imageUrl] as String),
      romaji: json[TKanas.romaji] as String,
      strokesQuantity: json[TKanas.strokesQuantity] as int,
    );
  }
}
