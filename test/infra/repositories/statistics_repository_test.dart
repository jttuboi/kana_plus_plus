import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks.dart';

void main() {
  final mockDatabase = MockDatabase();
  final repository = StatisticsRepository(mockDatabase);

  group('StatisticsRepository', () {
    group('statisticCount', () {
      Future<void> testIncreaseMethod({required String databaseTag, required int previousQuantity, required Function increaseMethodQuantity}) async {
        when(() => mockDatabase.load(BoxTag.statisticCount)).thenAnswer((_) => Future.value());
        when(() => mockDatabase.get(databaseTag, defaultValue: 0)).thenAnswer((_) => Future.value(previousQuantity));
        when(() => mockDatabase.put(databaseTag, previousQuantity + 1)).thenAnswer((_) => Future.value());

        await increaseMethodQuantity();

        verify(() => mockDatabase.get(databaseTag, defaultValue: 0)).called(1);
        verify(() => mockDatabase.put(databaseTag, previousQuantity + 1)).called(1);
      }

      test('increases show hint quantity', () {
        testIncreaseMethod(
          databaseTag: DatabaseTag.showHintQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseShowHintQuantity(),
        );
      });

      test('increases not show hint quantity', () {
        testIncreaseMethod(
          databaseTag: DatabaseTag.notShowHintQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseNotShowHintQuantity(),
        );
      });

      test('increases kana type hiragana quantity', () {
        testIncreaseMethod(
          databaseTag: DatabaseTag.onlyHiraganaQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseOnlyHiraganaQuantity(),
        );
      });

      test('increases kana type katakana quantity', () {
        testIncreaseMethod(
          databaseTag: DatabaseTag.onlyKatakanaQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseOnlyKatakanaQuantity(),
        );
      });

      test('increases kana type both quantity', () {
        testIncreaseMethod(
          databaseTag: DatabaseTag.bothQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseBothQuantity(),
        );
      });

      test('increases training quantity', () {
        testIncreaseMethod(
          databaseTag: DatabaseTag.trainingQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseTrainingQuantity(),
        );
      });

      test('increases word correct quantity', () {
        testIncreaseMethod(
          databaseTag: DatabaseTag.wordCorrectQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseWordCorrectQuantity(),
        );
      });

      test('increases word wrong quantity', () {
        testIncreaseMethod(
          databaseTag: DatabaseTag.wordWrongQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseWordWrongQuantity(),
        );
      });

      test('increases kana correct quantity', () {
        testIncreaseMethod(
          databaseTag: DatabaseTag.kanaCorrectQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseKanaCorrectQuantity(),
        );
      });

      test('increases kana wrong quantity', () {
        testIncreaseMethod(
          databaseTag: DatabaseTag.kanaWrongQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseKanaWrongQuantity(),
        );
      });

      Future<void> testSpecificIncreaseMethod({
        required String key,
        required String tag,
        required int previousQuantity,
        required Function increaseMethodQuantity,
      }) async {
        final valueOfNewMap = <String, int>{key: previousQuantity + 1};
        when(() => mockDatabase.load(BoxTag.statisticCount)).thenAnswer((_) => Future.value());
        when(() => mockDatabase.get(tag, defaultValue: <String, int>{})).thenAnswer((_) => valueOfNewMap);
        when(() => mockDatabase.put(tag, valueOfNewMap)).thenAnswer((_) => Future.value());

        await increaseMethodQuantity();

        verify(() => mockDatabase.get(tag, defaultValue: <String, int>{})).called(1);
        verify(() => mockDatabase.put(tag, valueOfNewMap)).called(1);
      }

      test('increases specific word correct quantity', () {
        testSpecificIncreaseMethod(
          key: DatabaseTag.keySpecificWordCorrectQuantity('あめ'),
          tag: DatabaseTag.specificWordCorrectQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseSpecificWordCorrectQuantity('あめ'),
        );
      });

      test('increases specific word wrong quantity', () {
        testSpecificIncreaseMethod(
          key: DatabaseTag.keySpecificWordWrongQuantity('あめ'),
          tag: DatabaseTag.specificWordWrongQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseSpecificWordWrongQuantity('あめ'),
        );
      });

      test('increases specific kana correct quantity', () {
        testSpecificIncreaseMethod(
          key: DatabaseTag.keySpecificKanaCorrectQuantity('あめ'),
          tag: DatabaseTag.specificKanaCorrectQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseSpecificKanaCorrectQuantity('あめ'),
        );
      });

      test('increases specific kana wrong quantity', () {
        testSpecificIncreaseMethod(
          key: DatabaseTag.keySpecificKanaWrongQuantity('あめ'),
          tag: DatabaseTag.specificKanaWrongQuantity,
          previousQuantity: 10,
          increaseMethodQuantity: () async => repository.increaseSpecificKanaWrongQuantity('あめ'),
        );
      });

      Future<void> testGetMethod({required String databaseTag, required int returnQuantity, required Function getMethodQuantity}) async {
        when(() => mockDatabase.load(BoxTag.statisticCount)).thenAnswer((_) => Future.value());
        when(() => mockDatabase.get(databaseTag, defaultValue: 0)).thenAnswer((_) => Future.value(returnQuantity));

        final result = await getMethodQuantity();

        expect(result, returnQuantity);
        verify(() => mockDatabase.get(databaseTag, defaultValue: 0)).called(1);
      }

      test('gets show hint quantity', () {
        testGetMethod(
          databaseTag: DatabaseTag.showHintQuantity,
          returnQuantity: 10,
          getMethodQuantity: () async => repository.showHintQuantity(),
        );
      });

      test('gets not show hint quantity', () {
        testGetMethod(
          databaseTag: DatabaseTag.notShowHintQuantity,
          returnQuantity: 10,
          getMethodQuantity: () async => repository.notShowHintQuantity(),
        );
      });

      test('gets both kana type quantity', () {
        testGetMethod(
          databaseTag: DatabaseTag.bothQuantity,
          returnQuantity: 10,
          getMethodQuantity: () async => repository.bothQuantity(),
        );
      });

      test('gets only kana type hiragana quantity', () {
        testGetMethod(
          databaseTag: DatabaseTag.onlyHiraganaQuantity,
          returnQuantity: 10,
          getMethodQuantity: () async => repository.onlyHiraganaQuantity(),
        );
      });

      test('gets only kana type katakana quantity', () {
        testGetMethod(
          databaseTag: DatabaseTag.onlyKatakanaQuantity,
          returnQuantity: 10,
          getMethodQuantity: () async => repository.onlyKatakanaQuantity(),
        );
      });

      test('gets training quantity', () {
        testGetMethod(
          databaseTag: DatabaseTag.trainingQuantity,
          returnQuantity: 10,
          getMethodQuantity: () async => repository.trainingQuantity(),
        );
      });

      test('gets specific word correct quantity', () async {
        when(() => mockDatabase.load(BoxTag.statisticCount)).thenAnswer((_) => Future.value());
        when(() => mockDatabase.get(DatabaseTag.specificWordCorrectQuantity, defaultValue: <String, int>{})).thenAnswer((_) {
          return {'correct_word_354417': 10, 'correct_word_363417': 11, 'correct_word_358375': 12, 'correct_word_358414': 13};
        });
        final result = await repository.specificWordCorrectQuantityByWordIds(['あめ', 'かめ']);

        expect(result, {'あめ': 10, 'かめ': 11});
        verify(() => mockDatabase.get(DatabaseTag.specificWordCorrectQuantity, defaultValue: <String, int>{})).called(1);
      });

      test('gets specific word wrong quantity', () async {
        when(() => mockDatabase.load(BoxTag.statisticCount)).thenAnswer((_) => Future.value());
        when(() => mockDatabase.get(DatabaseTag.specificWordWrongQuantity, defaultValue: <String, int>{})).thenAnswer((_) {
          return {'wrong_word_354417': 10, 'wrong_word_363417': 11, 'wrong_word_358375': 12, 'wrong_word_358414': 13};
        });
        final result = await repository.specificWordWrongQuantityByWordIds(['あめ', 'かめ']);

        expect(result, {'あめ': 10, 'かめ': 11});
        verify(() => mockDatabase.get(DatabaseTag.specificWordWrongQuantity, defaultValue: <String, int>{})).called(1);
      });

      test('gets specific kana correct quantity', () async {
        when(() => mockDatabase.load(BoxTag.statisticCount)).thenAnswer((_) => Future.value());
        when(() => mockDatabase.get(DatabaseTag.specificKanaCorrectQuantity, defaultValue: <String, int>{})).thenAnswer((_) {
          return {'correct_kana_354': 10, 'correct_kana_363': 11, 'correct_kana_375': 12, 'correct_kana_358': 13};
        });
        final result = await repository.specificKanaCorrectQuantityByKanaIds(['あ', 'か']);

        expect(result, {'あ': 10, 'か': 11});
        verify(() => mockDatabase.get(DatabaseTag.specificKanaCorrectQuantity, defaultValue: <String, int>{})).called(1);
      });

      test('gets specific kana wrong quantity', () async {
        when(() => mockDatabase.load(BoxTag.statisticCount)).thenAnswer((_) => Future.value());
        when(() => mockDatabase.get(DatabaseTag.specificKanaWrongQuantity, defaultValue: <String, int>{})).thenAnswer((_) {
          return {'wrong_kana_354': 10, 'wrong_kana_363': 11, 'wrong_kana_375': 12, 'wrong_kana_358': 13};
        });
        final result = await repository.specificKanaWrongQuantityByKanaIds(['あ', 'か']);

        expect(result, {'あ': 10, 'か': 11});
        verify(() => mockDatabase.get(DatabaseTag.specificKanaWrongQuantity, defaultValue: <String, int>{})).called(1);
      });
    });

    group('statisticObjects', () {
      test('saves training statistics data', () async {
        when(() => mockDatabase.load(BoxTag.statisticObjects)).thenAnswer((_) => Future.value());
        when(() => mockDatabase.add(trainingStats)).thenAnswer((_) => Future.value());

        await repository.saveTrainingStats(trainingStats);

        verify(() => mockDatabase.add(trainingStats)).called(1);
      });

      test('gets avg words per training statistics data', () async {
        when(() => mockDatabase.load(BoxTag.statisticObjects)).thenAnswer((_) => Future.value());
        when(() => mockDatabase.values).thenAnswer((_) => listTrainingStats.take(listTrainingStats.length));

        final avgResult = await repository.avgWordsPerTraining();

        expect(avgResult, 8);
        verify(() => mockDatabase.values).called(2);
      });

      test('gets training statistics data', () async {
        when(() => mockDatabase.load(BoxTag.statisticObjects)).thenAnswer((_) => Future.value());
        when(() => mockDatabase.values).thenAnswer((_) => listTrainingStats.take(listTrainingStats.length));

        final result = await repository.getTrainingStats();

        expect(result, listTrainingStats);
        verify(() => mockDatabase.values).called(1);
      });
    });
  });
}

const listTrainingStats = [
  TrainingStats(showHint: true, type: KanaType.both, wordsQuantity: 5, words: []),
  TrainingStats(showHint: true, type: KanaType.both, wordsQuantity: 7, words: []),
  TrainingStats(showHint: true, type: KanaType.both, wordsQuantity: 8, words: []),
  TrainingStats(showHint: true, type: KanaType.both, wordsQuantity: 9, words: []),
  TrainingStats(showHint: true, type: KanaType.both, wordsQuantity: 11, words: []),
];

const trainingStats = TrainingStats(
  showHint: true,
  type: KanaType.both,
  wordsQuantity: 5,
  words: [
    WordStats(id: 'あめ', correct: true, kanas: [KanaStats(id: 'あ', correct: true, strokes: []), KanaStats(id: 'め', correct: true, strokes: [])]),
    WordStats(id: 'あめ', correct: true, kanas: [KanaStats(id: 'あ', correct: true, strokes: []), KanaStats(id: 'め', correct: true, strokes: [])]),
    WordStats(id: 'あめ', correct: true, kanas: [KanaStats(id: 'あ', correct: true, strokes: []), KanaStats(id: 'め', correct: true, strokes: [])]),
    WordStats(id: 'あめ', correct: true, kanas: [KanaStats(id: 'あ', correct: true, strokes: []), KanaStats(id: 'め', correct: true, strokes: [])]),
    WordStats(id: 'あめ', correct: true, kanas: [KanaStats(id: 'あ', correct: true, strokes: []), KanaStats(id: 'め', correct: true, strokes: [])]),
  ],
);
