import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('KanaModel', () {
    test('must initiate properly values', () {
      expect(kanaModel.id, 'id 1');
      expect(kanaModel.kanaType, KanaType.hiragana);
      expect(kanaModel.romaji, 'romaji 1');
      expect(kanaModel.strokes, ['STROKE 1', 'STROKE 2']);
    });

    test('fromJson returns KanaModel from json data', () {
      final result = KanaModel.fromJson(const {
        'id': 'id 1',
        'type': 'h',
        'romaji': 'romaji 1',
        'strokes': ['STROKE 1', 'STROKE 2']
      });

      expect(result, kanaModel);
    });

    test('copyWith copies the current with new values added to it', () {
      final newKana = kanaModel.copyWith(id: 'id 2', romaji: 'romaji 2');
      final newKana2 = kanaModel.copyWith(kanaType: KanaType.katakana, strokes: ['STROKE 3']);

      expect(newKana, const KanaModel(id: 'id 2', kanaType: KanaType.hiragana, romaji: 'romaji 2', strokes: ['STROKE 1', 'STROKE 2']));
      expect(newKana2, const KanaModel(id: 'id 1', kanaType: KanaType.katakana, romaji: 'romaji 1', strokes: ['STROKE 3']));
    });
  });
}

const kanaModel = KanaModel(
  id: 'id 1',
  kanaType: KanaType.hiragana,
  romaji: 'romaji 1',
  strokes: ['STROKE 1', 'STROKE 2'],
);
