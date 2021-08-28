import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/domain/enums/update_kana_situation.dart';
import 'package:kana_plus_plus/src/domain/repositories/word.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_viewer_content.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final wordRepository = WordRepositoryMock();
  final controller = TrainingController(
    wordRepository: wordRepository,
    kanaType: KanaType.hiragana,
    quantityOfWords: 10,
  );
  test("training controller init test", () {
    final repository1 = WordRepositoryMock();
    final controller1 = TrainingController(wordRepository: repository1, kanaType: KanaType.hiragana, quantityOfWords: 1);

    expect(controller1.wordRepository, repository1);
    expect(controller1.kanaType, KanaType.hiragana);
    expect(controller1.quantityOfWords, 1);

    final repository2 = WordRepositoryMock();
    final controller2 = TrainingController(wordRepository: repository2, kanaType: KanaType.both, quantityOfWords: 423);

    expect(controller2.wordRepository, repository2);
    expect(controller2.kanaType, KanaType.both);
    expect(controller2.quantityOfWords, 423);
  });

  group("images url", () {
    test("must return quit icon url", () {
      expect(controller.quitIconUrl, IconUrl.quitTraining);
    });
    test("must return square image url", () {
      expect(controller.squareImageUrl, ImageUrl.square);
    });
    test("must return correct image url", () {
      expect(controller.correctImageUrl, ImageUrl.correct);
    });
    test("must return wrong image url", () {
      expect(controller.wrongImageUrl, ImageUrl.wrong);
    });
  });
  // TODO test("must return wrong image url", () {
  // precisa colocar os dados que vem do vbanco de dados e checar no wordsToTraining
  //when(() => wordRepository.getWord(wordId)).thenAnswer((_) => Future.value(wordSample1));

  //final result = controller.isReady;

  // verify(() => _generateDataForTest).called(1); // precisa chamar o dado certo
  //  expect(result, completion(isTrue));
  //expect(controller.wordsToTraining, matcher)
  // });

  test("must return current word image url", () {
    controller.wordsToTraining = wordsContent;

    const wordIdxToCheck1 = 0;
    controller.wordIdx = wordIdxToCheck1;
    expect(controller.currentImageUrl, controller.wordsToTraining[wordIdxToCheck1].imageUrl);

    const wordIdxToCheck2 = 1;
    controller.wordIdx = wordIdxToCheck2;
    expect(controller.currentImageUrl, controller.wordsToTraining[wordIdxToCheck2].imageUrl);

    const wordIdxToCheck3 = 2;
    controller.wordIdx = wordIdxToCheck3;
    expect(controller.currentImageUrl, controller.wordsToTraining[wordIdxToCheck3].imageUrl);
  });
  test("must return the max strokes from current kana of current word", () {
    controller.wordsToTraining = wordsContent;

    controller.wordIdx = 0;
    controller.kanaIdx = 0;
    expect(controller.currentKanaMaxStrokes, 3);

    controller.wordIdx = 0;
    controller.kanaIdx = 1;
    expect(controller.currentKanaMaxStrokes, 2);

    controller.wordIdx = 1;
    controller.kanaIdx = 0;
    expect(controller.currentKanaMaxStrokes, 3);

    controller.wordIdx = 1;
    controller.kanaIdx = 1;
    expect(controller.currentKanaMaxStrokes, 1);

    controller.wordIdx = 1;
    controller.kanaIdx = 2;
    expect(controller.currentKanaMaxStrokes, 4);

    controller.wordIdx = 1;
    controller.kanaIdx = 3;
    expect(controller.currentKanaMaxStrokes, 3);

    controller.wordIdx = 2;
    controller.kanaIdx = 0;
    expect(controller.currentKanaMaxStrokes, 3);

    controller.wordIdx = 2;
    controller.kanaIdx = 1;
    expect(controller.currentKanaMaxStrokes, 2);

    controller.wordIdx = 2;
    controller.kanaIdx = 2;
    expect(controller.currentKanaMaxStrokes, 5);
  });
  test("must return image url of current kana", () {
    controller.wordsToTraining = wordsContent;
    controller.wordIdx = 1;
    controller.kanaIdx = 1;

    expect(controller.currentKanaImageUrl, "shi.png");
  });
  test("must return the kana type from current kana of current word", () {
    controller.wordsToTraining = wordsContent;

    controller.wordIdx = 0;
    controller.kanaIdx = 0;
    expect(controller.currentKanaType, KanaType.hiragana);

    controller.wordIdx = 0;
    controller.kanaIdx = 1;
    expect(controller.currentKanaType, KanaType.hiragana);

    controller.wordIdx = 1;
    controller.kanaIdx = 0;
    expect(controller.currentKanaType, KanaType.hiragana);

    controller.wordIdx = 1;
    controller.kanaIdx = 1;
    expect(controller.currentKanaType, KanaType.hiragana);

    controller.wordIdx = 1;
    controller.kanaIdx = 2;
    expect(controller.currentKanaType, KanaType.katakana);

    controller.wordIdx = 1;
    controller.kanaIdx = 3;
    expect(controller.currentKanaType, KanaType.katakana);

    controller.wordIdx = 2;
    controller.kanaIdx = 0;
    expect(controller.currentKanaType, KanaType.katakana);

    controller.wordIdx = 2;
    controller.kanaIdx = 1;
    expect(controller.currentKanaType, KanaType.katakana);

    controller.wordIdx = 2;
    controller.kanaIdx = 2;
    expect(controller.currentKanaType, KanaType.katakana);
  });
  test("must return the max of kanas of word", () {
    controller.wordsToTraining = wordsContent;

    expect(controller.getMaxKanasOfWord(0), 2);
    expect(controller.getMaxKanasOfWord(1), 4);
    expect(controller.getMaxKanasOfWord(2), 3);
  });

  test("must return kana", () {
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
  group("update kana", () {
    test("must change to next kana in the same word", () {
      controller.wordsToTraining = [
        WordViewerContent(id: 36, text: "あめ", imageUrl: "rain.png", kanas: [
          KanaViewerContent(
              id: 0,
              status: KanaViewerStatus.showSelected,
              kanaImageUrl: "a.png",
              romajiImageUrl: "ra.png",
              strokesNumber: 3,
              kanaType: KanaType.hiragana),
          KanaViewerContent(
              id: 33,
              status: KanaViewerStatus.showInitial,
              kanaImageUrl: "me.png",
              romajiImageUrl: "rme.png",
              strokesNumber: 2,
              kanaType: KanaType.hiragana),
        ]),
      ];
      controller.kanaIdx = 0;
      controller.wordIdx = 0;

      const kanaId = 0; // あ
      const allStrokes = [
        [Offset(1, 1), Offset(4, 2), Offset(0, 4)],
        [Offset(9, 7), Offset(1, 2)],
      ];

      final status = controller.updateKana(allStrokes, kanaId);

      // these data can't change
      final word = controller.wordsToTraining[0];
      expect(controller.wordsToTraining.length, 1);
      expect(word.id, 36);
      expect(word.text, "あめ");
      expect(word.imageUrl, "rain.png");
      expect(word.kanas.length, 2);
      expect(word.kanas[0].id, 0);
      expect(word.kanas[0].kanaImageUrl, "a.png");
      expect(word.kanas[0].romajiImageUrl, "ra.png");
      expect(word.kanas[0].strokesNumber, 3);
      expect(word.kanas[0].kanaType, KanaType.hiragana);
      expect(word.kanas[1].id, 33);
      expect(word.kanas[1].kanaImageUrl, "me.png");
      expect(word.kanas[1].romajiImageUrl, "rme.png");
      expect(word.kanas[1].strokesNumber, 2);
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
    test("must change to next word after update the last kana", () {
      const firstStrokes = [
        [Offset(1, 1), Offset(4, 2), Offset(0, 4)],
        [Offset(9, 7), Offset(1, 2)],
      ];

      controller.wordsToTraining = [
        WordViewerContent(id: 36, text: "あめ", imageUrl: "rain.png", kanas: [
          KanaViewerContent(
              id: 0,
              status: KanaViewerStatus.showWrong,
              kanaImageUrl: "a.png",
              romajiImageUrl: "ra.png",
              strokesNumber: 3,
              kanaType: KanaType.hiragana,
              //kanaIdWrote: -1, // if is -1, the kana is not found
              strokesDrew: firstStrokes),
          KanaViewerContent(
              id: 33,
              status: KanaViewerStatus.showSelected,
              kanaImageUrl: "me.png",
              romajiImageUrl: "rme.png",
              strokesNumber: 2,
              kanaType: KanaType.hiragana),
        ]),
      ];
      controller.kanaIdx = 1;
      controller.wordIdx = 0;

      const kanaId = 1; // あ
      const allStrokes = [
        [Offset(1, 7), Offset(8, 3)],
        [Offset(3, 3), Offset(7, 3), Offset(9, 2)],
      ];

      final status = controller.updateKana(allStrokes, kanaId);

      // these data can't change
      final word = controller.wordsToTraining[0];
      expect(controller.wordsToTraining.length, 1);
      expect(word.id, 36);
      expect(word.text, "あめ");
      expect(word.imageUrl, "rain.png");
      expect(word.kanas.length, 2);
      expect(word.kanas[0].id, 0);
      expect(word.kanas[0].kanaImageUrl, "a.png");
      expect(word.kanas[0].romajiImageUrl, "ra.png");
      expect(word.kanas[0].strokesNumber, 3);
      expect(word.kanas[0].kanaType, KanaType.hiragana);
      expect(word.kanas[0].status, KanaViewerStatus.showWrong);
      expect(word.kanas[0].kanaIdWrote, -1);
      expect(word.kanas[0].strokesDrew, firstStrokes);
      expect(word.kanas[1].id, 33);
      expect(word.kanas[1].kanaImageUrl, "me.png");
      expect(word.kanas[1].romajiImageUrl, "rme.png");
      expect(word.kanas[1].strokesNumber, 2);
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
  test("must return words result with good data", () {
    controller.wordsToTraining = wordsContent;

    final result = controller.wordsResult;

    expect(result.length, 3);

    expect(result[0].id, 36);
    expect(result[0].text, "あめ");
    expect(result[0].imageUrl, "rain.png");
    expect(result[0].kanas.length, 2);
    expect(result[0].kanas[0].id, 0);
    expect(result[0].kanas[0].imageUrl, "a.png");
    expect(result[0].kanas[0].isCorrect, isTrue);
    expect(result[0].kanas[0].idWrote, 0);
    expect(result[0].kanas[0].strokesDrew, const [
      [Offset(1, 1)],
      [Offset(2, 2)],
      [Offset(3, 3)]
    ]);
    expect(result[0].kanas[1].id, 33);
    expect(result[0].kanas[1].imageUrl, "me.png");
    expect(result[0].kanas[1].isCorrect, isFalse);
    expect(result[0].kanas[1].idWrote, 2);
    expect(result[0].kanas[1].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);

    expect(result[1].id, 110);
    expect(result[1].text, "けしゴム");
    expect(result[1].imageUrl, "eraser.png");
    expect(result[1].kanas.length, 4);
    expect(result[1].kanas[0].id, 8);
    expect(result[1].kanas[0].imageUrl, "ke.png");
    expect(result[1].kanas[0].isCorrect, isFalse);
    expect(result[1].kanas[0].idWrote, 3);
    expect(result[1].kanas[0].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
    expect(result[1].kanas[1].id, 11);
    expect(result[1].kanas[1].imageUrl, "shi.png");
    expect(result[1].kanas[1].isCorrect, isTrue);
    expect(result[1].kanas[1].idWrote, 4);
    expect(result[1].kanas[1].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
    expect(result[1].kanas[2].id, 127);
    expect(result[1].kanas[2].imageUrl, "go.png");
    expect(result[1].kanas[2].isCorrect, isTrue);
    expect(result[1].kanas[2].idWrote, 5);
    expect(result[1].kanas[2].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
    expect(result[1].kanas[3].id, 109);
    expect(result[1].kanas[3].imageUrl, "mu.png");
    expect(result[1].kanas[3].isCorrect, isFalse);
    expect(result[1].kanas[3].idWrote, 6);
    expect(result[1].kanas[3].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);

    expect(result[2].id, 215);
    expect(result[2].text, "サラダ");
    expect(result[2].imageUrl, "salad.png");
    expect(result[2].kanas.length, 3);
    expect(result[2].kanas[0].id, 87);
    expect(result[2].kanas[0].imageUrl, "sa.png");
    expect(result[2].kanas[0].isCorrect, isTrue);
    expect(result[2].kanas[0].idWrote, 7);
    expect(result[2].kanas[0].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
    expect(result[2].kanas[1].id, 115);
    expect(result[2].kanas[1].imageUrl, "ra.png");
    expect(result[2].kanas[1].isCorrect, isTrue);
    expect(result[2].kanas[1].idWrote, 8);
    expect(result[2].kanas[1].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
    expect(result[2].kanas[2].id, 133);
    expect(result[2].kanas[2].imageUrl, "da.png");
    expect(result[2].kanas[2].isCorrect, isFalse);
    expect(result[2].kanas[2].idWrote, 5);
    expect(result[2].kanas[2].strokesDrew, const [
      [Offset(4, 4)],
      [Offset(5, 5)]
    ]);
  });
  test("what do when must return words result with unfinished data", () {
    // wordResult retrieval should never be beyond retrieval during page change to
    // review page. However, it is possible to access this data at any time, so to
    // avoid data misreading problems, data not yet studied will be filled with
    // empty data.
    controller.wordsToTraining = [
      WordViewerContent(id: 36, text: "あめ", imageUrl: "rain.png", kanas: [
        KanaViewerContent(
            id: 0,
            // if showSelected or showInitial, is considered isCorrect = false
            status: KanaViewerStatus.showSelected,
            kanaImageUrl: "a.png",
            romajiImageUrl: "ra.png",
            strokesNumber: 3,
            kanaType: KanaType.hiragana),
        KanaViewerContent(
            id: 33,
            // if showSelected or showInitial, is considered isCorrect = false
            status: KanaViewerStatus.showInitial,
            kanaImageUrl: "me.png",
            romajiImageUrl: "rme.png",
            strokesNumber: 2,
            kanaType: KanaType.hiragana),
      ]),
    ];

    final result = controller.wordsResult;

    expect(result[0].kanas[0].isCorrect, isFalse);
    expect(result[0].kanas[0].imageUrl, "a.png");
    expect(result[0].kanas[0].idWrote, -1);
    expect(result[0].kanas[0].strokesDrew, []);

    expect(result[0].kanas[1].isCorrect, isFalse);
    expect(result[0].kanas[1].imageUrl, "me.png");
    expect(result[0].kanas[1].idWrote, -1);
    expect(result[0].kanas[1].strokesDrew, []);
  });
}

class WordRepositoryMock extends Mock implements IWordRepository {}

final List<WordViewerContent> wordsContent = [
  WordViewerContent(id: 36, text: "あめ", imageUrl: "rain.png", kanas: [
    KanaViewerContent(
        id: 0,
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: "a.png",
        romajiImageUrl: "ra.png",
        strokesNumber: 3,
        kanaType: KanaType.hiragana,
        kanaIdWrote: 0,
        strokesDrew: const [
          [Offset(1, 1)],
          [Offset(2, 2)],
          [Offset(3, 3)],
        ]),
    KanaViewerContent(
        id: 33,
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: "me.png",
        romajiImageUrl: "rme.png",
        strokesNumber: 2,
        kanaType: KanaType.hiragana,
        kanaIdWrote: 2,
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
  ]),
  WordViewerContent(id: 110, text: "けしゴム", imageUrl: "eraser.png", kanas: [
    KanaViewerContent(
        id: 8,
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: "ke.png",
        romajiImageUrl: "rke.png",
        strokesNumber: 3,
        kanaType: KanaType.hiragana,
        kanaIdWrote: 3,
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
    KanaViewerContent(
        id: 11,
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: "shi.png",
        romajiImageUrl: "rshi.png",
        strokesNumber: 1,
        kanaType: KanaType.hiragana,
        kanaIdWrote: 4,
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
    KanaViewerContent(
        id: 127,
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: "go.png",
        romajiImageUrl: "rgo.png",
        strokesNumber: 4,
        kanaType: KanaType.katakana,
        kanaIdWrote: 5,
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
    KanaViewerContent(
        id: 109,
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: "mu.png",
        romajiImageUrl: "rmu.png",
        strokesNumber: 3,
        kanaType: KanaType.katakana,
        kanaIdWrote: 6,
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
  ]),
  WordViewerContent(id: 215, text: "サラダ", imageUrl: "salad.png", kanas: [
    KanaViewerContent(
        id: 87,
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: "sa.png",
        romajiImageUrl: "rsa.png",
        strokesNumber: 3,
        kanaType: KanaType.katakana,
        kanaIdWrote: 7,
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
    KanaViewerContent(
        id: 115,
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: "ra.png",
        romajiImageUrl: "rra.png",
        strokesNumber: 2,
        kanaType: KanaType.katakana,
        kanaIdWrote: 8,
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
    KanaViewerContent(
        id: 133,
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: "da.png",
        romajiImageUrl: "rda.png",
        strokesNumber: 5,
        kanaType: KanaType.katakana,
        kanaIdWrote: 5,
        strokesDrew: const [
          [Offset(4, 4)],
          [Offset(5, 5)],
        ]),
  ]),
];
