import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_type.dart';

class Kana {
  const Kana({
    required this.id,
    required this.type,
    required this.imageUrl,
    this.romaji = '',
    this.romajiImageUrl = ImageUrl.empty,
    this.strokesQuantity = 0,
  });

  const Kana.empty()
      : id = '',
        type = KanaType.none,
        imageUrl = ImageUrl.empty,
        romaji = '',
        romajiImageUrl = ImageUrl.empty,
        strokesQuantity = 0;

  final String id;
  final KanaType type;
  final String imageUrl;
  final String romaji;
  final String romajiImageUrl;
  final int strokesQuantity;

  @override
  String toString() {
    return 'Kana($id, $type, $imageUrl, $romaji, $romajiImageUrl, $strokesQuantity)';
  }
}
