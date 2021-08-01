import 'package:kana_plus_plus/src/domain/entities/kana.entity.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/translate.entity.dart';

class Word {
  const Word({
    required this.id,
    required this.word,
    required this.imageUrl,
    this.romaji = "",
    this.type = KanaType.none,
    this.translate = const Translate.empty(),
    this.kanas = const [],
  });

  const Word.empty()
      : id = -1,
        word = "",
        // TODO precisa ser o link de uma imagem vazia para nao dar erro
        imageUrl = "",
        romaji = "",
        type = KanaType.none,
        translate = const Translate.empty(),
        kanas = const [];

  final int id;
  final String word;
  final String imageUrl;
  final String romaji;
  final KanaType type;
  final Translate translate;
  final List<Kana> kanas;

  @override
  String toString() {
    return "Word($id, $word, $imageUrl, $romaji, $type, $translate, $kanas)";
  }
}
