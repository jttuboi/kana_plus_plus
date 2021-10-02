import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/domain/controllers/training.controller.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/domain/entities/training_stats.dart';
import 'package:kana_plus_plus/src/domain/entities/word_viewer_content.dart';
import 'package:kana_plus_plus/src/domain/repositories/statistics.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/word.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/support/kana_checker.dart';
import 'package:kana_plus_plus/src/domain/utils/kana_type.dart';
import 'package:kana_plus_plus/src/domain/utils/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/domain/utils/update_kana_situation.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_result.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  test('must init controller with correct data passed via parameter', () {
    final wordRepository = WordRepositoryMock();
    final statisticsRepository = StatisticsRepositoryMock();
    final kanaChecker = KanaChecker();

    final controller1 = TrainingController(
      wordRepository: wordRepository,
      statisticsRepository: statisticsRepository,
      kanaChecker: kanaChecker,
      showHint: false,
      kanaType: KanaType.hiragana,
      quantityOfWords: 10,
    );

    expect(controller1.wordRepository, wordRepository);
    expect(controller1.statisticsRepository, statisticsRepository);
    expect(controller1.showHint, false);
    expect(controller1.kanaType, KanaType.hiragana);
    expect(controller1.quantityOfWords, 10);

    final controller2 = TrainingController(
      wordRepository: wordRepository,
      statisticsRepository: statisticsRepository,
      kanaChecker: kanaChecker,
      showHint: true,
      kanaType: KanaType.both,
      quantityOfWords: 5,
    );

    expect(controller2.wordRepository, wordRepository);
    expect(controller2.statisticsRepository, statisticsRepository);
    expect(controller2.showHint, true);
    expect(controller2.kanaType, KanaType.both);
    expect(controller2.quantityOfWords, 5);

    final controller3 = TrainingController(
      wordRepository: wordRepository,
      statisticsRepository: statisticsRepository,
      kanaChecker: kanaChecker,
      showHint: true,
      kanaType: KanaType.katakana,
      quantityOfWords: 20,
    );

    expect(controller3.wordRepository, wordRepository);
    expect(controller3.statisticsRepository, statisticsRepository);
    expect(controller3.showHint, true);
    expect(controller3.kanaType, KanaType.katakana);
    expect(controller3.quantityOfWords, 20);
  });

  test('must return current word image url', () {
    final controller = trainingControllerForWordTest();
    controller.wordsToTraining = wordsContent;

    const wordIdxToCheck1 = 0;
    controller.wordIdx = wordIdxToCheck1;
    expect(controller.wordImageUrl, controller.wordsToTraining[wordIdxToCheck1].imageUrl);

    const wordIdxToCheck2 = 1;
    controller.wordIdx = wordIdxToCheck2;
    expect(controller.wordImageUrl, controller.wordsToTraining[wordIdxToCheck2].imageUrl);

    const wordIdxToCheck3 = 2;
    controller.wordIdx = wordIdxToCheck3;
    expect(controller.wordImageUrl, controller.wordsToTraining[wordIdxToCheck3].imageUrl);
  });
  test('must return the max strokes from current kana of current word', () {
    final controller = trainingControllerForWordTest();
    controller.wordsToTraining = wordsContent;

    controller.wordIdx = 0;
    controller.kanaIdx = 0;
    expect(controller.currentKanaToWrite.maxStrokes, 3);

    controller.wordIdx = 0;
    controller.kanaIdx = 1;
    expect(controller.currentKanaToWrite.maxStrokes, 2);

    controller.wordIdx = 1;
    controller.kanaIdx = 0;
    expect(controller.currentKanaToWrite.maxStrokes, 3);

    controller.wordIdx = 1;
    controller.kanaIdx = 1;
    expect(controller.currentKanaToWrite.maxStrokes, 1);

    controller.wordIdx = 1;
    controller.kanaIdx = 2;
    expect(controller.currentKanaToWrite.maxStrokes, 4);

    controller.wordIdx = 1;
    controller.kanaIdx = 3;
    expect(controller.currentKanaToWrite.maxStrokes, 3);

    controller.wordIdx = 2;
    controller.kanaIdx = 0;
    expect(controller.currentKanaToWrite.maxStrokes, 3);

    controller.wordIdx = 2;
    controller.kanaIdx = 1;
    expect(controller.currentKanaToWrite.maxStrokes, 2);

    controller.wordIdx = 2;
    controller.kanaIdx = 2;
    expect(controller.currentKanaToWrite.maxStrokes, 5);
  });
  test('must return image url of current kana', () {
    final controller = trainingControllerForWordTest();
    controller.wordsToTraining = wordsContent;
    controller.wordIdx = 1;
    controller.kanaIdx = 1;

    expect(controller.currentKanaToWrite.hintImageUrl, 'shi.png');
  });
  test('must return the kana type from current kana of current word', () {
    final controller = trainingControllerForWordTest();
    controller.wordsToTraining = wordsContent;

    controller.wordIdx = 0;
    controller.kanaIdx = 0;
    expect(controller.currentKanaToWrite.type, KanaType.hiragana);

    controller.wordIdx = 0;
    controller.kanaIdx = 1;
    expect(controller.currentKanaToWrite.type, KanaType.hiragana);

    controller.wordIdx = 1;
    controller.kanaIdx = 0;
    expect(controller.currentKanaToWrite.type, KanaType.hiragana);

    controller.wordIdx = 1;
    controller.kanaIdx = 1;
    expect(controller.currentKanaToWrite.type, KanaType.hiragana);

    controller.wordIdx = 1;
    controller.kanaIdx = 2;
    expect(controller.currentKanaToWrite.type, KanaType.katakana);

    controller.wordIdx = 1;
    controller.kanaIdx = 3;
    expect(controller.currentKanaToWrite.type, KanaType.katakana);

    controller.wordIdx = 2;
    controller.kanaIdx = 0;
    expect(controller.currentKanaToWrite.type, KanaType.katakana);

    controller.wordIdx = 2;
    controller.kanaIdx = 1;
    expect(controller.currentKanaToWrite.type, KanaType.katakana);

    controller.wordIdx = 2;
    controller.kanaIdx = 2;
    expect(controller.currentKanaToWrite.type, KanaType.katakana);
  });
  test('must return the max of kanas of word', () {
    final controller = trainingControllerForWordTest();
    controller.wordsToTraining = wordsContent;

    expect(controller.maxKanasOfWord(0), 2);
    expect(controller.maxKanasOfWord(1), 4);
    expect(controller.maxKanasOfWord(2), 3);
  });

  test('must return kana', () {
    final controller = trainingControllerForWordTest();
    controller.wordsToTraining = wordsContent;

    expect(controller.kanaOfWord(0, 0), controller.wordsToTraining[0].kanas[0]);
    expect(controller.kanaOfWord(0, 1), controller.wordsToTraining[0].kanas[1]);

    expect(controller.kanaOfWord(1, 0), controller.wordsToTraining[1].kanas[0]);
    expect(controller.kanaOfWord(1, 1), controller.wordsToTraining[1].kanas[1]);
    expect(controller.kanaOfWord(1, 2), controller.wordsToTraining[1].kanas[2]);
    expect(controller.kanaOfWord(1, 3), controller.wordsToTraining[1].kanas[3]);

    expect(controller.kanaOfWord(2, 0), controller.wordsToTraining[2].kanas[0]);
    expect(controller.kanaOfWord(2, 1), controller.wordsToTraining[2].kanas[1]);
    expect(controller.kanaOfWord(2, 2), controller.wordsToTraining[2].kanas[2]);
  });
  group('update kana', () {
    test('must change to next kana in the same word', () {
      final controller = trainingControllerForWordTest();
      controller.wordsToTraining = [
        WordViewerContent(id: 'あめ', imageUrl: 'rain.png', kanas: [
          KanaViewerContent(
            id: 'あ',
            status: KanaViewerStatus.showSelected,
            kanaImageUrl: 'a.png',
            romaji: 'a',
            strokesQuantity: 3,
            kanaType: KanaType.hiragana,
          ),
          KanaViewerContent(
            id: 'め',
            status: KanaViewerStatus.showInitial,
            kanaImageUrl: 'me.png',
            romaji: 'me',
            strokesQuantity: 2,
            kanaType: KanaType.hiragana,
          ),
        ]),
      ];
      controller.kanaIdx = 0;
      controller.wordIdx = 0;

      const kanaId = 'あ';
      const allStrokes = [
        [Offset(1, 1), Offset(4, 2), Offset(0, 4)],
        [Offset(9, 7), Offset(1, 2)],
      ];

      final status = controller.updateKana(allStrokes, kanaId);

      // these data can't change
      final word = controller.wordsToTraining[0];
      expect(controller.wordsToTraining.length, 1);
      expect(word.id, 'あめ');
      expect(word.imageUrl, 'rain.png');
      expect(word.kanas.length, 2);
      expect(word.kanas[0].id, 'あ');
      expect(word.kanas[0].kanaImageUrl, 'a.png');
      expect(word.kanas[0].romaji, 'a');
      expect(word.kanas[0].strokesQuantity, 3);
      expect(word.kanas[0].kanaType, KanaType.hiragana);
      expect(word.kanas[1].id, 'め');
      expect(word.kanas[1].kanaImageUrl, 'me.png');
      expect(word.kanas[1].romaji, 'me');
      expect(word.kanas[1].strokesQuantity, 2);
      expect(word.kanas[1].kanaType, KanaType.hiragana);

      // these data need change
      expect(status, UpdateKanaSituation.changeKana);
      expect(word.kanas[0].status, KanaViewerStatus.showCorrect);
      expect(word.kanas[0].kanaIdWrote, kanaId);
      expect(word.kanas[0].strokesDrew, allStrokes);
      expect(word.kanas[1].status, KanaViewerStatus.showSelected);
      expect(word.kanas[1].strokesDrew, isEmpty);
      expect(controller.kanaIdx, 1);
      expect(controller.wordIdx, 0);
    });
    test('must change to next word after update the last kana', () {
      final controller = trainingControllerForWordTest();
      const firstStrokes = [
        [Offset(1, 1), Offset(4, 2), Offset(0, 4)],
        [Offset(9, 7), Offset(1, 2)],
      ];

      controller.wordsToTraining = [
        WordViewerContent(id: 'あめ', imageUrl: 'rain.png', kanas: [
          KanaViewerContent(
            id: 'あ',
            status: KanaViewerStatus.showWrong,
            kanaImageUrl: 'a.png',
            romaji: 'a',
            strokesQuantity: 3,
            kanaType: KanaType.hiragana,
            strokesDrew: firstStrokes,
          ),
          KanaViewerContent(
            id: 'め',
            status: KanaViewerStatus.showSelected,
            kanaImageUrl: 'me.png',
            romaji: 'me',
            strokesQuantity: 2,
            kanaType: KanaType.hiragana,
          ),
        ]),
      ];
      controller.kanaIdx = 1;
      controller.wordIdx = 0;

      const kanaId = 'あ';
      const allStrokes = [
        [Offset(1, 7), Offset(8, 3)],
        [Offset(3, 3), Offset(7, 3), Offset(9, 2)],
      ];

      final status = controller.updateKana(allStrokes, kanaId);

      // these data can't change
      final word = controller.wordsToTraining[0];
      expect(controller.wordsToTraining.length, 1);
      expect(word.id, 'あめ');
      expect(word.imageUrl, 'rain.png');
      expect(word.kanas.length, 2);
      expect(word.kanas[0].id, 'あ');
      expect(word.kanas[0].kanaImageUrl, 'a.png');
      expect(word.kanas[0].romaji, 'a');
      expect(word.kanas[0].strokesQuantity, 3);
      expect(word.kanas[0].kanaType, KanaType.hiragana);
      expect(word.kanas[0].status, KanaViewerStatus.showWrong);
      expect(word.kanas[0].kanaIdWrote, '');
      expect(word.kanas[0].strokesDrew, firstStrokes);
      expect(word.kanas[1].id, 'め');
      expect(word.kanas[1].kanaImageUrl, 'me.png');
      expect(word.kanas[1].romaji, 'me');
      expect(word.kanas[1].strokesQuantity, 2);
      expect(word.kanas[1].kanaType, KanaType.hiragana);

      // these data need change
      expect(status, UpdateKanaSituation.changeTheLastWord);
      expect(word.kanas[1].status, KanaViewerStatus.showWrong);
      expect(word.kanas[1].kanaIdWrote, kanaId);
      expect(word.kanas[1].strokesDrew, allStrokes);
      expect(controller.kanaIdx, 0);
      expect(controller.wordIdx, 1);
    });
  });
  test('must return words result with good data', () {
    final controller = trainingControllerForWordTest();
    controller.wordsToTraining = wordsContent;

    final result = controller.wordsResult;

    expect(result.length, 3);

    expect(result[0].id, 'あめ');
    expect(result[0].imageUrl, 'rain.png');
    expect(result[0].kanas.length, 2);
    expect(result[0].kanas[0].id, 'あ');
    expect(result[0].kanas[0].isCorrect, isTrue);
    expect(result[0].kanas[0].idWrote, 'あ');
    expect(result[0].kanas[0].strokesDrew, const [
      [Offset(1, 1)],
      [Offset(2, 2)],
      [Offset(3, 3)]
    ]);
    expect(result[0].kanas[1].id, 'め');
    expect(result[0].kanas[1].isCorrect, isFalse);
    expect(result[0].kanas[1].idWrote, 'あ');
    expect(result[0].kanas[1].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);

    expect(result[1].id, 'けしゴム');
    expect(result[1].imageUrl, 'eraser.png');
    expect(result[1].kanas.length, 4);
    expect(result[1].kanas[0].id, 'け');
    expect(result[1].kanas[0].isCorrect, isFalse);
    expect(result[1].kanas[0].idWrote, 'あ');
    expect(result[1].kanas[0].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
    expect(result[1].kanas[1].id, 'し');
    expect(result[1].kanas[1].isCorrect, isTrue);
    expect(result[1].kanas[1].idWrote, 'あ');
    expect(result[1].kanas[1].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
    expect(result[1].kanas[2].id, 'ゴ');
    expect(result[1].kanas[2].isCorrect, isTrue);
    expect(result[1].kanas[2].idWrote, 'あ');
    expect(result[1].kanas[2].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
    expect(result[1].kanas[3].id, 'ム');
    expect(result[1].kanas[3].isCorrect, isFalse);
    expect(result[1].kanas[3].idWrote, 'あ');
    expect(result[1].kanas[3].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);

    expect(result[2].id, 'サラダ');
    expect(result[2].imageUrl, 'salad.png');
    expect(result[2].kanas.length, 3);
    expect(result[2].kanas[0].id, 'サ');
    expect(result[2].kanas[0].isCorrect, isTrue);
    expect(result[2].kanas[0].idWrote, 'あ');
    expect(result[2].kanas[0].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
    expect(result[2].kanas[1].id, 'ラ');
    expect(result[2].kanas[1].isCorrect, isTrue);
    expect(result[2].kanas[1].idWrote, 'あ');
    expect(result[2].kanas[1].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
    expect(result[2].kanas[2].id, 'ダ');
    expect(result[2].kanas[2].isCorrect, isFalse);
    expect(result[2].kanas[2].idWrote, 'あ');
    expect(result[2].kanas[2].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
  });
  test('what do when must return words result with unfinished data', () {
    final controller = trainingControllerForWordTest();
    // wordResult retrieval should never be beyond retrieval during page change to
    // review page. However, it is possible to access this data at any time, so to
    // avoid data misreading problems, data not yet studied will be filled with
    // empty data.
    controller.wordsToTraining = [
      WordViewerContent(id: 'あめ', imageUrl: 'rain.png', kanas: [
        KanaViewerContent(
          id: 'あ',
          // if showSelected or showInitial, is considered isCorrect = false
          status: KanaViewerStatus.showSelected,
          kanaImageUrl: 'a.png',
          romaji: 'a',
          strokesQuantity: 3,
          kanaType: KanaType.hiragana,
        ),
        KanaViewerContent(
          id: 'め',
          // if showSelected or showInitial, is considered isCorrect = false
          status: KanaViewerStatus.showInitial,
          kanaImageUrl: 'me.png',
          romaji: 'me',
          strokesQuantity: 2,
          kanaType: KanaType.hiragana,
        ),
      ]),
    ];

    final result = controller.wordsResult;

    expect(result[0].kanas[0].isCorrect, isFalse);
    expect(result[0].kanas[0].idWrote, '');
    expect(result[0].kanas[0].strokesDrew, []);

    expect(result[0].kanas[1].isCorrect, isFalse);
    expect(result[0].kanas[1].idWrote, '');
    expect(result[0].kanas[1].strokesDrew, []);
  });
  test('must call increase show hint quantity', () {
    final repository = StatisticsRepositoryMock();
    // ignore: avoid_redundant_argument_values
    final controller = trainingControllerForStatisticTest(repository, showHint: true);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseShowHintQuantity()).called(1);
  });
  test('must call increase not show hint quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = trainingControllerForStatisticTest(repository, showHint: false);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseNotShowHintQuantity()).called(1);
  });
  test('must call increase hiragana quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = trainingControllerForStatisticTest(repository, kanaType: KanaType.hiragana);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseOnlyHiraganaQuantity()).called(1);
  });
  test('must call increase only katakana quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = trainingControllerForStatisticTest(repository, kanaType: KanaType.katakana);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseOnlyKatakanaQuantity()).called(1);
  });
  test('must call increase both quantity', () {
    final repository = StatisticsRepositoryMock();
    // ignore: avoid_redundant_argument_values
    final controller = trainingControllerForStatisticTest(repository, kanaType: KanaType.both);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseBothQuantity()).called(1);
  });
  test('must call increase training quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = trainingControllerForStatisticTest(repository);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseTrainingQuantity()).called(1);
  });
  test('must call increase word correct quantity and increase specific word correct quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = trainingControllerForStatisticTest(repository);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseWordCorrectQuantity()).called(1);
    verify(() => repository.increaseSpecificWordCorrectQuantity('ushi')).called(1);
  });
  test('must call increase word wrong quantity and increase specific word wrong quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = trainingControllerForStatisticTest(repository);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseWordWrongQuantity()).called(4);
    verify(() => repository.increaseSpecificWordWrongQuantity('umi')).called(1);
    verify(() => repository.increaseSpecificWordWrongQuantity('ao')).called(1);
    verify(() => repository.increaseSpecificWordWrongQuantity('ki')).called(1);
    verify(() => repository.increaseSpecificWordWrongQuantity('ame')).called(1);
  });
  test('must call increase kana correct quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = trainingControllerForStatisticTest(repository);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.increaseKanaCorrectQuantity()).called(4);
    verify(() => repository.increaseSpecificKanaCorrectQuantity('u')).called(2);
    verify(() => repository.increaseSpecificKanaCorrectQuantity('me')).called(1);
    verify(() => repository.increaseSpecificKanaCorrectQuantity('shi')).called(1);
  });
  test('must call increase kana wrong quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = trainingControllerForStatisticTest(repository);

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
    final controller = trainingControllerForStatisticTest(repository);

    controller.updateStatistics(wordsResult5);

    verify(() => repository.saveTrainingStats(any<TrainingStatsFake>())).called(1);
  });
}

TrainingController trainingControllerForWordTest() {
  return TrainingController(
    wordRepository: WordRepositoryMock(),
    statisticsRepository: StatisticsRepositoryMock(),
    kanaChecker: KanaChecker(),
    showHint: true,
    kanaType: KanaType.both,
    quantityOfWords: 5,
  );
}

TrainingController trainingControllerForStatisticTest(
  IStatisticsRepository repository, {
  bool showHint = true,
  KanaType kanaType = KanaType.both,
  int quantityOfWords = 5,
}) {
  return TrainingController(
    wordRepository: WordRepositoryMock(),
    kanaChecker: KanaChecker(),
    statisticsRepository: repository,
    showHint: showHint,
    kanaType: kanaType,
    quantityOfWords: quantityOfWords,
  );
}

class WordRepositoryMock extends Mock implements IWordRepository {}

class StatisticsRepositoryMock extends Mock implements IStatisticsRepository {}

class TrainingStatsFake extends Fake implements TrainingStats {}

final List<WordViewerContent> wordsContent = [
  WordViewerContent(id: 'あめ', imageUrl: 'rain.png', kanas: [
    KanaViewerContent(
        id: 'あ',
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: 'a.png',
        romaji: 'a',
        strokesQuantity: 3,
        kanaType: KanaType.hiragana,
        kanaIdWrote: 'あ',
        strokesDrew: const [
          [Offset(1, 1)],
          [Offset(2, 2)],
          [Offset(3, 3)],
        ]),
    KanaViewerContent(
        id: 'め',
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: 'me.png',
        romaji: 'me',
        strokesQuantity: 2,
        kanaType: KanaType.hiragana,
        kanaIdWrote: 'あ',
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
  ]),
  WordViewerContent(id: 'けしゴム', imageUrl: 'eraser.png', kanas: [
    KanaViewerContent(
        id: 'け',
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: 'ke.png',
        romaji: 'ke',
        strokesQuantity: 3,
        kanaType: KanaType.hiragana,
        kanaIdWrote: 'あ',
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
    KanaViewerContent(
        id: 'し',
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: 'shi.png',
        romaji: 'shi',
        strokesQuantity: 1,
        kanaType: KanaType.hiragana,
        kanaIdWrote: 'あ',
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
    KanaViewerContent(
        id: 'ゴ',
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: 'go.png',
        romaji: 'go',
        strokesQuantity: 4,
        kanaType: KanaType.katakana,
        kanaIdWrote: 'あ',
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
    KanaViewerContent(
        id: 'ム',
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: 'mu.png',
        romaji: 'mu',
        strokesQuantity: 3,
        kanaType: KanaType.katakana,
        kanaIdWrote: 'あ',
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
  ]),
  WordViewerContent(id: 'サラダ', imageUrl: 'salad.png', kanas: [
    KanaViewerContent(
        id: 'サ',
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: 'sa.png',
        romaji: 'sa',
        strokesQuantity: 3,
        kanaType: KanaType.katakana,
        kanaIdWrote: 'あ',
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
    KanaViewerContent(
        id: 'ラ',
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: 'ra.png',
        romaji: 'ra',
        strokesQuantity: 2,
        kanaType: KanaType.katakana,
        kanaIdWrote: 'あ',
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
    KanaViewerContent(
        id: 'ダ',
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: 'da.png',
        romaji: 'da',
        strokesQuantity: 5,
        kanaType: KanaType.katakana,
        kanaIdWrote: 'あ',
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
  ]),
];

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
