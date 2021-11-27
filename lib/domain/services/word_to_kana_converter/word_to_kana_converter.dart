import 'package:kwriting/domain/domain.dart';

class WordToKanaConverter {
  List<KanaModel> convert(String wordId, Map<String, KanaModel> kanasMap) {
    final kanas = <KanaModel>[];

    for (var i = 0; i < wordId.length; i++) {
      final String kanaId;
      final String romaji;
      final KanaType kanaType;
      final List<String> strokes;
      final currentChar = wordId[i];

      // when it's not the last char
      if (i + 1 < wordId.length) {
        final nextChar = wordId[i + 1];
        if (['ゃ', 'ゅ', 'ょ', 'ャ', 'ュ', 'ョ', 'ァ', 'ィ', 'ゥ', 'ェ', 'ォ'].contains(nextChar)) {
          i++;
          kanaId = currentChar + nextChar;
          romaji = kanasMap[kanaId]!.romaji;
          kanaType = kanasMap[kanaId]!.kanaType;
          strokes = kanasMap[kanaId]!.strokes;
        } else if (['っ', 'ッ'].contains(currentChar)) {
          kanaId = currentChar;
          romaji = kanasMap[nextChar]!.romaji[0];
          kanaType = kanasMap[kanaId]!.kanaType;
          strokes = kanasMap[kanaId]!.strokes;
        } else if ('ー' == currentChar) {
          final previousChar = wordId[i - 1];
          final previousRomaji = kanasMap[previousChar]!.romaji;
          kanaId = currentChar;
          romaji = previousRomaji[previousRomaji.length - 1];
          kanaType = kanasMap[kanaId]!.kanaType;
          strokes = kanasMap[kanaId]!.strokes;
        } else {
          kanaId = currentChar;
          romaji = kanasMap[kanaId]!.romaji;
          kanaType = kanasMap[kanaId]!.kanaType;
          strokes = kanasMap[kanaId]!.strokes;
        }
      }
      // when it's the last char
      else {
        if ('ー' == currentChar) {
          final previousChar = wordId[i - 1];
          final previousRomaji = kanasMap[previousChar]!.romaji;
          kanaId = currentChar;
          romaji = previousRomaji[previousRomaji.length - 1];
          kanaType = kanasMap[kanaId]!.kanaType;
          strokes = kanasMap[kanaId]!.strokes;
        } else {
          kanaId = currentChar;
          romaji = kanasMap[kanaId]!.romaji;
          kanaType = kanasMap[kanaId]!.kanaType;
          strokes = kanasMap[kanaId]!.strokes;
        }
      }

      kanas.add(KanaModel(
        id: kanaId,
        romaji: romaji,
        kanaType: kanaType,
        strokes: strokes,
      ));
    }

    // to check kana id and romaji
    //inspect(kanas.map((e) => "('${e.id}','${e.romaji}')").toList());
    return kanas;
  }
}
