import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/training/training.dart';

class WordToKanaConverter {
  List<Kana> convert(String wordId, Map<String, Kana> kanasMap) {
    final kanas = <Kana>[];

    for (var i = 0; i < wordId.length; i++) {
      final String kanaId;
      final String romaji;
      final KanaType type;
      final String imageUrl;
      final int strokesQuantity;
      final currentChar = wordId[i];

      // when it's not the last char
      if (i + 1 < wordId.length) {
        final nextChar = wordId[i + 1];
        if (['ゃ', 'ゅ', 'ょ', 'ャ', 'ュ', 'ョ', 'ァ', 'ィ', 'ゥ', 'ェ', 'ォ'].contains(nextChar)) {
          i++;
          kanaId = currentChar + nextChar;
          romaji = kanasMap[kanaId]!.romaji;
          type = kanasMap[kanaId]!.type;
          imageUrl = kanasMap[kanaId]!.imageUrl;
          strokesQuantity = kanasMap[kanaId]!.strokesQuantity;
        } else if (['っ', 'ッ'].contains(currentChar)) {
          kanaId = currentChar;
          romaji = kanasMap[nextChar]!.romaji[0];
          type = kanasMap[kanaId]!.type;
          imageUrl = kanasMap[kanaId]!.imageUrl;
          strokesQuantity = kanasMap[kanaId]!.strokesQuantity;
        } else if ('ー' == currentChar) {
          final previousChar = wordId[i - 1];
          final previousRomaji = kanasMap[previousChar]!.romaji;
          kanaId = currentChar;
          romaji = previousRomaji[previousRomaji.length - 1];
          type = kanasMap[kanaId]!.type;
          imageUrl = kanasMap[kanaId]!.imageUrl;
          strokesQuantity = kanasMap[kanaId]!.strokesQuantity;
        } else {
          kanaId = currentChar;
          romaji = kanasMap[kanaId]!.romaji;
          type = kanasMap[kanaId]!.type;
          imageUrl = kanasMap[kanaId]!.imageUrl;
          strokesQuantity = kanasMap[kanaId]!.strokesQuantity;
        }
      }
      // when it's the last char
      else {
        if ('ー' == currentChar) {
          final previousChar = wordId[i - 1];
          final previousRomaji = kanasMap[previousChar]!.romaji;
          kanaId = currentChar;
          romaji = previousRomaji[previousRomaji.length - 1];
          type = kanasMap[kanaId]!.type;
          imageUrl = kanasMap[kanaId]!.imageUrl;
          strokesQuantity = kanasMap[kanaId]!.strokesQuantity;
        } else {
          kanaId = currentChar;
          romaji = kanasMap[kanaId]!.romaji;
          type = kanasMap[kanaId]!.type;
          imageUrl = kanasMap[kanaId]!.imageUrl;
          strokesQuantity = kanasMap[kanaId]!.strokesQuantity;
        }
      }

      kanas.add(Kana(
        id: kanaId,
        romaji: romaji,
        type: type,
        imageUrl: imageUrl,
        strokesQuantity: strokesQuantity,
      ));
    }

    // to check kana id and romaji
    //inspect(kanas.map((e) => "('${e.id}','${e.romaji}')").toList());
    return kanas;
  }
}
