import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/kana.entity.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/translate.entity.dart';

class Word {
  const Word({
    required this.id,
    required this.text,
    required this.imageUrl,
    this.romaji = '',
    this.type = KanaType.none,
    this.translate = const Translate.empty(),
    this.kanas = const [],
  });

  const Word.empty()
      : id = -1,
        text = '',
        imageUrl = ImageUrl.empty,
        romaji = '',
        type = KanaType.none,
        translate = const Translate.empty(),
        kanas = const [];

  final int id;
  final String text;
  final String imageUrl;
  final String romaji;
  final KanaType type;
  final Translate translate;
  final List<Kana> kanas;

  @override
  String toString() {
    return 'Word($id, $text, $imageUrl, $romaji, $type, $translate, $kanas)';
  }
}
