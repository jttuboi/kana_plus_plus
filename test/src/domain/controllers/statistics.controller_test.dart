import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/domain/controllers/statistics.controller.dart';
import 'package:kana_plus_plus/src/domain/core/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/training_stats.dart';
import 'package:kana_plus_plus/src/domain/repositories/statistics.interface.repository.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_result.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  test('must init controller with correct data passed via parameter', () {
    final repository = StatisticsRepositoryMock();
    final controller1 = StatisticsController(statisticsRepository: repository, showHint: false, kanaType: KanaType.hiragana, quantityOfWords: 10);

    expect(controller1.showHint, false);
    expect(controller1.kanaType, KanaType.hiragana);
    expect(controller1.quantityOfWords, 10);

    final controller2 = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);

    expect(controller2.showHint, true);
    expect(controller2.kanaType, KanaType.both);
    expect(controller2.quantityOfWords, 5);

    final controller3 = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.katakana, quantityOfWords: 20);

    expect(controller3.showHint, true);
    expect(controller3.kanaType, KanaType.katakana);
    expect(controller3.quantityOfWords, 20);
  });
  test('must call increase show hint quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseShowHintQuantity()).called(1);
  });
  test('must call increase not show hint quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: false, kanaType: KanaType.both, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseNotShowHintQuantity()).called(1);
  });
  test('must call increase hiragana quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.hiragana, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseOnlyHiraganaQuantity()).called(1);
  });
  test('must call increase only katakana quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.katakana, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseOnlyKatakanaQuantity()).called(1);
  });
  test('must call increase both quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseBothQuantity()).called(1);
  });
  test('must call increase training quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseTrainingQuantity()).called(1);
  });
  test('must call increase word correct quantity and increase specific word correct quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseWordCorrectQuantity()).called(1);
    verify(() => repository.increaseSpecificWordCorrectQuantity('ushi')).called(1);
  });
  test('must call increase word wrong quantity and increase specific word wrong quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseWordWrongQuantity()).called(4);
    verify(() => repository.increaseSpecificWordWrongQuantity('umi')).called(1);
    verify(() => repository.increaseSpecificWordWrongQuantity('ao')).called(1);
    verify(() => repository.increaseSpecificWordWrongQuantity('ki')).called(1);
    verify(() => repository.increaseSpecificWordWrongQuantity('ame')).called(1);
  });
  test('must call increase kana correct quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseKanaCorrectQuantity()).called(4);
    verify(() => repository.increaseSpecificKanaCorrectQuantity('u')).called(2);
    verify(() => repository.increaseSpecificKanaCorrectQuantity('me')).called(1);
    verify(() => repository.increaseSpecificKanaCorrectQuantity('shi')).called(1);
  });
  test('must call increase kana wrong quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseKanaWrongQuantity()).called(5);
    verify(() => repository.increaseSpecificKanaWrongQuantity('mi')).called(1);
    verify(() => repository.increaseSpecificKanaWrongQuantity('a')).called(2);
    verify(() => repository.increaseSpecificKanaWrongQuantity('o')).called(1);
    verify(() => repository.increaseSpecificKanaWrongQuantity('ki')).called(1);
  });
  test('must call save training stats', () {
    registerFallbackValue(TrainingStatsFake());
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.saveTrainingStats(any<TrainingStatsFake>())).called(1);
  });
  test('must return show hint quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);
    when(() => repository.showHintQuantity()).thenReturn(13);

    expect(controller.showHintQuantity, 13);
    verify(() => repository.showHintQuantity()).called(1);
  });
  test('must return not show hint quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);
    when(() => repository.notShowHintQuantity()).thenReturn(453);

    expect(controller.notShowHintQuantity, 453);
    verify(() => repository.notShowHintQuantity()).called(1);
  });
  test('must return only hiragana quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);
    when(() => repository.onlyHiraganaQuantity()).thenReturn(34);

    expect(controller.onlyHiraganaQuantity, 34);
    verify(() => repository.onlyHiraganaQuantity()).called(1);
  });
  test('must return only katakana quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);
    when(() => repository.onlyKatakanaQuantity()).thenReturn(678);

    expect(controller.onlyKatakanaQuantity, 678);
    verify(() => repository.onlyKatakanaQuantity()).called(1);
  });
  test('must return both quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);
    when(() => repository.bothQuantity()).thenReturn(234);

    expect(controller.bothQuantity, 234);
    verify(() => repository.bothQuantity()).called(1);
  });
  test('must return training quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);
    when(() => repository.trainingQuantity()).thenReturn(159);

    expect(controller.trainingQuantity, 159);
    verify(() => repository.trainingQuantity()).called(1);
  });
  test('must return avg words per training', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);
    when(() => repository.wordQuantitiesOfTraining()).thenReturn([1, 2, 3]);

    expect(controller.avgWordsPerTraining, 2.0);
    verify(() => repository.wordQuantitiesOfTraining()).called(1);
  });
  test('must return avg words per training 2', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository, showHint: true, kanaType: KanaType.both, quantityOfWords: 5);
    when(() => repository.wordQuantitiesOfTraining()).thenReturn([1, 2, 3, 5]);

    expect(controller.avgWordsPerTraining, 2.75);
    verify(() => repository.wordQuantitiesOfTraining()).called(1);
  });
}

class StatisticsRepositoryMock extends Mock implements IStatisticsRepository {}

class TrainingStatsFake extends Fake implements TrainingStats {}

const wordsResult5 = [
  WordResult(id: 'umi', imageUrl: 'umi.svg', kanas: [
    KanaResult(id: 'u', isCorrect: true, idWrote: 'u', strokesDrew: [
      [Offset(0, 1), Offset(1, 1)],
      [Offset(0, 1), Offset(0.7, 0.7), Offset(1, 1)],
      [Offset(0.1, 0), Offset(0.2, 0.4), Offset(1, 1)],
    ]),
    KanaResult(id: 'mi', isCorrect: false, idWrote: 'mo', strokesDrew: [
      [Offset(0, 1), Offset(4, 4)],
      [Offset(0, 1), Offset(0.3, 0.3), Offset(1, 1)],
    ]),
  ]),
  WordResult(id: 'ao', imageUrl: 'ao.svg', kanas: [
    KanaResult(id: 'a', isCorrect: false, idWrote: 'u', strokesDrew: [
      [Offset(0, 1), Offset(1, 1)],
      [Offset(0, 1), Offset(0.7, 0.7), Offset(1, 1)],
      [Offset(0, 0.4), Offset(0.2, 0.4), Offset(1, 1)],
    ]),
    KanaResult(id: 'o', isCorrect: false, idWrote: 'i', strokesDrew: [
      [Offset(0, 1), Offset(4, 4)],
      [Offset(0, 1), Offset(0.3, 0.3), Offset(1, 1)],
    ]),
  ]),
  WordResult(id: 'ki', imageUrl: 'ki.svg', kanas: [
    KanaResult(id: 'ki', isCorrect: false, idWrote: 'ka', strokesDrew: [
      [Offset(0, 1), Offset(4, 4)],
      [Offset(0, 1), Offset(0.3, 0.3), Offset(1, 1)],
      [Offset(0, 1), Offset(4, 4)],
    ]),
  ]),
  WordResult(id: 'ame', imageUrl: 'ame.svg', kanas: [
    KanaResult(id: 'a', isCorrect: false, idWrote: 'e', strokesDrew: [
      [Offset(0, 1), Offset(1, 1)],
      [Offset(0, 0.5), Offset(0.2, 0.4), Offset(1, 1)],
    ]),
    KanaResult(id: 'me', isCorrect: true, idWrote: 'me', strokesDrew: [
      [Offset(0, 1), Offset(4, 4)],
      [Offset(0, 1), Offset(0.3, 0.3), Offset(1, 1)],
    ]),
  ]),
  WordResult(id: 'ushi', imageUrl: 'ushi.svg', kanas: [
    KanaResult(id: 'u', isCorrect: true, idWrote: 'u', strokesDrew: [
      [Offset(0, 1), Offset(1, 1)],
      [Offset(0, 0.5), Offset(0.2, 0.4), Offset(1, 1)],
    ]),
    KanaResult(id: 'shi', isCorrect: true, idWrote: 'shi', strokesDrew: [
      [Offset(0, 1), Offset(4, 4)],
    ]),
  ]),
];

// const trainingStats5 = TrainingStats(
//   showHint: true,
//   type: KanaType.both,
//   wordsQuantity: 5,
//   words: [
//     WordStats(id: 'umi', correct: false, kanas: [
//       KanaStats(id: 'u', correct: true, idWrote: 'u', strokes: [
//         StrokeStats(points: [Offset(0, 1), Offset(1, 1)]),
//         StrokeStats(points: [Offset(0, 1), Offset(0.7, 0.7), Offset(1, 1)]),
//         StrokeStats(points: [Offset(0.1, 0), Offset(0.2, 0.4), Offset(1, 1)]),
//       ]),
//       KanaStats(id: 'mi', correct: false, idWrote: 'mo', strokes: [
//         StrokeStats(points: [Offset(0, 1), Offset(4, 4)]),
//         StrokeStats(points: [Offset(0, 1), Offset(0.3, 0.3), Offset(1, 1)]),
//       ])
//     ]),
//     WordStats(id: 'ao', correct: false, kanas: [
//       KanaStats(id: 'a', correct: false, idWrote: 'u', strokes: [
//         StrokeStats(points: [Offset(0, 1), Offset(1, 1)]),
//         StrokeStats(points: [Offset(0, 1), Offset(0.7, 0.7), Offset(1, 1)]),
//         StrokeStats(points: [Offset(0, 0.4), Offset(0.2, 0.4), Offset(1, 1)]),
//       ]),
//       KanaStats(id: 'o', correct: false, idWrote: 'i', strokes: [
//         StrokeStats(points: [Offset(0, 1), Offset(4, 4)]),
//         StrokeStats(points: [Offset(0, 1), Offset(0.3, 0.3), Offset(1, 1)]),
//       ])
//     ]),
//     WordStats(id: 'ki', correct: false, kanas: [
//       KanaStats(id: 'ki', correct: false, idWrote: 'ka', strokes: [
//         StrokeStats(points: [Offset(0, 1), Offset(4, 4)]),
//         StrokeStats(points: [Offset(0, 1), Offset(0.3, 0.3), Offset(1, 1)]),
//         StrokeStats(points: [Offset(0, 1), Offset(4, 4)]),
//       ]),
//     ]),
//     WordStats(id: 'ame', correct: false, kanas: [
//       KanaStats(id: 'a', correct: false, idWrote: 'e', strokes: [
//         StrokeStats(points: [Offset(0, 1), Offset(1, 1)]),
//         StrokeStats(points: [Offset(0, 0.5), Offset(0.2, 0.4), Offset(1, 1)]),
//       ]),
//       KanaStats(id: 'me', correct: true, idWrote: 'me', strokes: [
//         StrokeStats(points: [Offset(0, 1), Offset(4, 4)]),
//         StrokeStats(points: [Offset(0, 1), Offset(0.3, 0.3), Offset(1, 1)]),
//       ])
//     ]),
//     WordStats(id: 'ushi', correct: true, kanas: [
//       KanaStats(id: 'u', correct: true, idWrote: 'u', strokes: [
//         StrokeStats(points: [Offset(0, 1), Offset(1, 1)]),
//         StrokeStats(points: [Offset(0, 0.5), Offset(0.2, 0.4), Offset(1, 1)]),
//       ]),
//       KanaStats(id: 'shi', correct: true, idWrote: 'shi', strokes: [
//         StrokeStats(points: [Offset(0, 1), Offset(4, 4)]),
//       ])
//     ]),
//   ],
// );
