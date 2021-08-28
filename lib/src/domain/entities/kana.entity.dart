import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';

class Kana {
  const Kana({
    required this.id,
    required this.text,
    required this.type,
    required this.imageUrl,
    this.romaji = '',
    this.romajiImageUrl = ImageUrl.empty,
    this.numberStrokes = 0,
  });

  const Kana.empty()
      : id = -1,
        text = '',
        type = KanaType.none,
        imageUrl = ImageUrl.empty,
        romaji = '',
        romajiImageUrl = ImageUrl.empty,
        numberStrokes = 0;

  final int id;
  final String text;
  final KanaType type;
  final String imageUrl;
  final String romaji;
  final String romajiImageUrl;
  final int numberStrokes;

  @override
  String toString() {
    return 'Kana($id, $text, $type, $imageUrl, $romaji, $romajiImageUrl, $numberStrokes)';
  }
}
