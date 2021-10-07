import 'package:kwriting/src/data/datasources/image_url.storage.dart';
import 'package:kwriting/src/domain/utils/kana_type.dart';

class Kana {
  const Kana({
    required this.id,
    required this.type,
    required this.imageUrl,
    this.romaji = '',
    this.strokesQuantity = 0,
  });

  const Kana.empty()
      : id = '',
        type = KanaType.none,
        imageUrl = ImageUrl.empty,
        romaji = '',
        strokesQuantity = 0;

  final String id;
  final KanaType type;
  final String imageUrl;
  final String romaji;
  final int strokesQuantity;

  @override
  String toString() {
    return 'Kana($id, $type, $imageUrl, $romaji, $strokesQuantity)';
  }
}
