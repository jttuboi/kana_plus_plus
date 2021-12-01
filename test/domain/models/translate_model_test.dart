import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('TranslateModel', () {
    test('must initiate properly values', () {
      expect(translateModel.id, 'translate id');
      expect(translateModel.english, 'english');
      expect(translateModel.portuguese, 'portugues');
      expect(translateModel.spanish, 'spanol');
    });

    test('returns empty', () {
      const empty = TranslateModel.empty;
      expect(empty.id, isEmpty);
      expect(empty.english, isEmpty);
      expect(empty.portuguese, isEmpty);
      expect(empty.spanish, isEmpty);
    });

    test('fromJson creates TranslateModel from json data', () {
      final translateModelFromJson = TranslateModel.fromJson(const {
        'id': 'translate id',
        'en': 'english',
        'pt': 'portugues',
        'es': 'spanol',
      });

      expect(translateModelFromJson, translateModel);
    });

    test('copyWith copies TranslateModel with new values', () {
      final translate1 = translateModel.copyWith(id: 'new id', spanish: 'new espanhol');
      final translate2 = translateModel.copyWith(english: 'new english', portuguese: 'new portuguese');

      expect(translate1, const TranslateModel(id: 'new id', english: 'english', portuguese: 'portugues', spanish: 'new espanhol'));
      expect(translate2, const TranslateModel(id: 'translate id', english: 'new english', portuguese: 'new portuguese', spanish: 'spanol'));
    });

    test('toTranslateStr returns the value giving a languageCode', () {
      expect(translateModel.toTranslateStr('en'), 'english');
      expect(translateModel.toTranslateStr('es'), 'spanol');
      expect(translateModel.toTranslateStr('pt'), 'portugues');
    });
  });
}

const translateModel = TranslateModel(
  id: 'translate id',
  english: 'english',
  portuguese: 'portugues',
  spanish: 'spanol',
);
