import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('WordModel', () {
    test('must initiate properly values', () {
      expect(wordModel.id, 'id');
      expect(wordModel.romaji, 'romaji');
      expect(wordModel.kanaType, KanaType.both);
      expect(wordModel.imageUrl, 'imageUrl.png');
      expect(wordModel.translate, const TranslateModel(id: 't id', english: 'english', portuguese: 'portuguese', spanish: 'spanish'));
      expect(wordModel.kanas, const [
        KanaModel(id: 'k id', kanaType: KanaType.katakana, romaji: 'romaji', strokes: ['A', 'B'])
      ]);
    });

    test('fromJson creates WordModel from json data', () {
      final jsonModel = WordModel.fromJson(const {
        'id': 'id a',
        'romaji': 'romaji a',
        'type': 'b',
        'imageUrl': 'imageUrl.png',
      });

      expect(jsonModel.id, 'id a');
      expect(jsonModel.romaji, 'romaji a');
      expect(jsonModel.kanaType, KanaType.both);
      expect(jsonModel.imageUrl, '${ImageUrl.imageFolder}imageUrl.png');
    });

    test('copyWith copies WordModel with new passed data', () {
      final newCopyWord1 = wordModel.copyWith(
        id: 'new id',
        kanaType: KanaType.both,
        translate: const TranslateModel(id: '', english: 'english', portuguese: 'portuguese', spanish: 'spanish'),
      );
      expect(newCopyWord1.id, 'new id');
      expect(newCopyWord1.kanaType, KanaType.both);
      expect(newCopyWord1.translate, const TranslateModel(id: '', english: 'english', portuguese: 'portuguese', spanish: 'spanish'));

      final newCopyWord2 = wordModel.copyWith(
        romaji: 'new romaji',
        imageUrl: 'new imageUrl',
        kanas: const [KanaModel(id: 'kana id', kanaType: KanaType.hiragana, romaji: 'romaji', strokes: [])],
      );
      expect(newCopyWord2.romaji, 'new romaji');
      expect(newCopyWord2.imageUrl, 'new imageUrl');
      expect(newCopyWord2.kanas, const [KanaModel(id: 'kana id', kanaType: KanaType.hiragana, romaji: 'romaji', strokes: [])]);
    });
  });
}

const wordModel = WordModel(
  id: 'id',
  romaji: 'romaji',
  kanaType: KanaType.both,
  imageUrl: 'imageUrl.png',
  translate: TranslateModel(id: 't id', english: 'english', portuguese: 'portuguese', spanish: 'spanish'),
  kanas: [
    KanaModel(id: 'k id', kanaType: KanaType.katakana, romaji: 'romaji', strokes: ['A', 'B']),
  ],
);
