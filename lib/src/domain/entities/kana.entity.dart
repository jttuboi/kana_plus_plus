import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';

class Kana {
  const Kana({
    required this.id,
    required this.kana,
    required this.type,
    required this.imageUrl,
    this.romaji = "",
    // TODO precisa trocar o vazio por uma imagem vazia
    this.romajiImageUrl = "",
    this.numberStrokes = 0,
  });

  const Kana.empty()
      : id = -1,
        kana = "",
        type = KanaType.none,
        // TODO precisa trocar o vazio por uma imagem vazia
        imageUrl = "",
        romaji = "",
        // TODO precisa trocar o vazio por uma imagem vazia
        romajiImageUrl = "",
        numberStrokes = 0;

  final int id;
  final String kana;
  final KanaType type;
  final String imageUrl;
  final String romaji;
  final String romajiImageUrl;
  final int numberStrokes;

  @override
  String toString() {
    return "Kana($id, $kana, $type, $imageUrl, $romaji, $romajiImageUrl, $numberStrokes)";
  }
}
