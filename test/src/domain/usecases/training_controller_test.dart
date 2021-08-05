import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/repositories/word.interface.dart';
import 'package:kana_plus_plus/src/domain/repositories/writing_hand.interface.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_viewer_content.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final wordRepository = WordRepositoryMock();
  final writingHandRepository = WritingHandRepositoryMock();
  final controller = TrainingController(
    wordRepository: wordRepository,
    writingHandRepository: writingHandRepository,
    showHint: true,
    kanaType: KanaType.hiragana,
    quantityOfWords: 10,
  );

  group("images url", () {
    test("must return quit icon url", () {
      final result = controller.quitIconUrl;

      expect(result, IconUrl.quitTraining);
    });
    test("must return square image url", () {
      final result = controller.squareImageUrl;

      expect(result, ImageUrl.square);
    });
    test("must return correct image url", () {
      final result = controller.correctImageUrl;

      expect(result, ImageUrl.correct);
    });
    test("must return wrong image url", () {
      final result = controller.wrongImageUrl;

      expect(result, ImageUrl.wrong);
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
    expect(controller.currentImageUrl,
        controller.wordsToTraining[wordIdxToCheck1].imageUrl);

    const wordIdxToCheck2 = 1;
    controller.wordIdx = wordIdxToCheck2;
    expect(controller.currentImageUrl,
        controller.wordsToTraining[wordIdxToCheck2].imageUrl);

    const wordIdxToCheck3 = 2;
    controller.wordIdx = wordIdxToCheck3;
    expect(controller.currentImageUrl,
        controller.wordsToTraining[wordIdxToCheck3].imageUrl);
  });
  test("must return the writing hand from repository", () {
    when(() => writingHandRepository.getWritingHandSelected())
        .thenAnswer((_) => WritingHand.left);

    final result = controller.getWritingHand;

    verify(() => writingHandRepository.getWritingHandSelected()).called(1);
    expect(result, WritingHand.left);
  });
  test("must return if is the last word to study", () {
    controller.wordsToTraining = wordsContent;

    controller.wordIdx = 1;
    final result = controller.isTheLastWord;
    expect(result, false);

    controller.wordIdx = 2;
    final result2 = controller.isTheLastWord;
    expect(result2, false);

    controller.wordIdx = 3;
    final result3 = controller.isTheLastWord;
    expect(result3, true);
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
              kanaType: KanaType.hiragana,
              userKana: null),
          KanaViewerContent(
              id: 33,
              status: KanaViewerStatus.showInitial,
              kanaImageUrl: "me.png",
              romajiImageUrl: "rme.png",
              strokesNumber: 2,
              kanaType: KanaType.hiragana,
              userKana: null),
        ]),
      ];
      controller.kanaIdx = 0;
      controller.wordIdx = 0;

      final kanaId = 0; // あ
      final imageDrew = Image.asset("lib/assets/images/h_a_test.png");
      bool isUpdateWhenWordChangedCalled = false;

      controller.updateKana([], kanaId, imageDrew, () {
        isUpdateWhenWordChangedCalled = true;
      });

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
      expect(word.kanas[0].status, KanaViewerStatus.showCorrect);
      expect(word.kanas[0].userKana.toString(),
          Image.asset("lib/assets/images/h_a_test.png").toString());
      expect(word.kanas[1].status, KanaViewerStatus.showSelected);
      expect(word.kanas[1].userKana, isNull);
      expect(isUpdateWhenWordChangedCalled, isFalse);
      expect(controller.kanaIdx, 1);
      expect(controller.wordIdx, 0);
    });
    test("must change to next word after update the last kana", () {
      controller.wordsToTraining = [
        WordViewerContent(id: 36, text: "あめ", imageUrl: "rain.png", kanas: [
          KanaViewerContent(
              id: 0,
              status: KanaViewerStatus.showWrong,
              kanaImageUrl: "a.png",
              romajiImageUrl: "ra.png",
              strokesNumber: 3,
              kanaType: KanaType.hiragana,
              userKana: Image.asset("lib/assets/images/h_a_test.png")),
          KanaViewerContent(
              id: 33,
              status: KanaViewerStatus.showSelected,
              kanaImageUrl: "me.png",
              romajiImageUrl: "rme.png",
              strokesNumber: 2,
              kanaType: KanaType.hiragana,
              userKana: null),
        ]),
      ];
      controller.kanaIdx = 1;
      controller.wordIdx = 0;

      final kanaId = 0; // あ
      final imageDrew = Image.asset("lib/assets/images/h_a_test.png");
      bool isUpdateWhenWordChangedCalled = false;

      controller.updateKana([], kanaId, imageDrew, () {
        isUpdateWhenWordChangedCalled = true;
      });

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
      expect(word.kanas[0].userKana.toString(),
          Image.asset("lib/assets/images/h_a_test.png").toString());
      expect(word.kanas[1].id, 33);
      expect(word.kanas[1].kanaImageUrl, "me.png");
      expect(word.kanas[1].romajiImageUrl, "rme.png");
      expect(word.kanas[1].strokesNumber, 2);
      expect(word.kanas[1].kanaType, KanaType.hiragana);

      // these data need change
      expect(word.kanas[1].status, KanaViewerStatus.showWrong);
      expect(word.kanas[1].userKana.toString(),
          Image.asset("lib/assets/images/h_a_test.png").toString());
      expect(isUpdateWhenWordChangedCalled, isTrue);
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
    expect(result[0].kanas[0].userImage, isNotNull);
    expect(result[0].kanas[1].id, 33);
    expect(result[0].kanas[1].imageUrl, "me.png");
    expect(result[0].kanas[1].isCorrect, isFalse);
    expect(result[0].kanas[1].userImage, isNotNull);

    expect(result[1].id, 110);
    expect(result[1].text, "けしゴム");
    expect(result[1].imageUrl, "eraser.png");
    expect(result[1].kanas.length, 4);
    expect(result[1].kanas[0].id, 8);
    expect(result[1].kanas[0].imageUrl, "ke.png");
    expect(result[1].kanas[0].isCorrect, isFalse);
    expect(result[1].kanas[0].userImage, isNotNull);
    expect(result[1].kanas[1].id, 11);
    expect(result[1].kanas[1].imageUrl, "shi.png");
    expect(result[1].kanas[1].isCorrect, isTrue);
    expect(result[1].kanas[1].userImage, isNotNull);
    expect(result[1].kanas[2].id, 127);
    expect(result[1].kanas[2].imageUrl, "go.png");
    expect(result[1].kanas[2].isCorrect, isTrue);
    expect(result[1].kanas[2].userImage, isNotNull);
    expect(result[1].kanas[3].id, 109);
    expect(result[1].kanas[3].imageUrl, "mu.png");
    expect(result[1].kanas[3].isCorrect, isFalse);
    expect(result[1].kanas[3].userImage, isNotNull);

    expect(result[2].id, 215);
    expect(result[2].text, "サラダ");
    expect(result[2].imageUrl, "salad.png");
    expect(result[2].kanas.length, 3);
    expect(result[2].kanas[0].id, 87);
    expect(result[2].kanas[0].imageUrl, "sa.png");
    expect(result[2].kanas[0].isCorrect, isTrue);
    expect(result[2].kanas[0].userImage, isNotNull);
    expect(result[2].kanas[1].id, 115);
    expect(result[2].kanas[1].imageUrl, "ra.png");
    expect(result[2].kanas[1].isCorrect, isTrue);
    expect(result[2].kanas[1].userImage, isNotNull);
    expect(result[2].kanas[2].id, 133);
    expect(result[2].kanas[2].imageUrl, "da.png");
    expect(result[2].kanas[2].isCorrect, isFalse);
    expect(result[2].kanas[2].userImage, isNotNull);
  });

  test("what do when must return words result with unfinished data", () {
    // wordResult retrieval should never be beyond retrieval during page change to
    // review page. However, it is possible to access this data at any time, so to
    // avoid data misreading problems, data not yet studied will be filled with
    // empty data.
    controller.wordsToTraining = [
      WordViewerContent(id: 36, text: "あめ", imageUrl: "rain.png", kanas: [
        const KanaViewerContent(
            id: 0,
            // if showSelected or showInitial, is considered isCorrect = false
            status: KanaViewerStatus.showSelected,
            kanaImageUrl: "a.png",
            romajiImageUrl: "ra.png",
            strokesNumber: 3,
            kanaType: KanaType.hiragana,
            // if null, the picture will be empty
            userKana: null),
        KanaViewerContent(
            id: 33,
            // if showSelected or showInitial, is considered isCorrect = false
            status: KanaViewerStatus.showInitial,
            kanaImageUrl: "me.png",
            romajiImageUrl: "rme.png",
            strokesNumber: 2,
            kanaType: KanaType.hiragana,
            userKana: Image.asset("lib/assets/images/h_a_test.png")),
      ]),
    ];

    final result = controller.wordsResult;

    expect(result[0].kanas[0].isCorrect, isFalse);
    expect(result[0].kanas[0].userImage, isNotNull);
    expect(result[0].kanas[0].userImage.toString(),
        Image.asset(ImageUrl.empty).toString());

    expect(result[0].kanas[1].isCorrect, isFalse);
    expect(result[0].kanas[1].userImage, isNotNull);
    expect(result[0].kanas[1].userImage.toString(),
        Image.asset("lib/assets/images/h_a_test.png").toString());
  });
}

class WordRepositoryMock extends Mock implements IWordRepository {}

class WritingHandRepositoryMock extends Mock implements IWritingHandRepository {
}

final List<WordViewerContent> wordsContent = [
  WordViewerContent(id: 36, text: "あめ", imageUrl: "rain.png", kanas: [
    KanaViewerContent(
        id: 0,
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: "a.png",
        romajiImageUrl: "ra.png",
        strokesNumber: 3,
        kanaType: KanaType.hiragana,
        userKana: Image.asset("lib/assets/images/h_a_test.png")),
    KanaViewerContent(
        id: 33,
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: "me.png",
        romajiImageUrl: "rme.png",
        strokesNumber: 2,
        kanaType: KanaType.hiragana,
        userKana: Image.asset("lib/assets/images/h_a_test.png")),
  ]),
  WordViewerContent(id: 110, text: "けしゴム", imageUrl: "eraser.png", kanas: [
    KanaViewerContent(
        id: 8,
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: "ke.png",
        romajiImageUrl: "rke.png",
        strokesNumber: 3,
        kanaType: KanaType.hiragana,
        userKana: Image.asset("lib/assets/images/h_a_test.png")),
    KanaViewerContent(
        id: 11,
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: "shi.png",
        romajiImageUrl: "rshi.png",
        strokesNumber: 1,
        kanaType: KanaType.hiragana,
        userKana: Image.asset("lib/assets/images/h_a_test.png")),
    KanaViewerContent(
        id: 127,
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: "go.png",
        romajiImageUrl: "rgo.png",
        strokesNumber: 4,
        kanaType: KanaType.katakana,
        userKana: Image.asset("lib/assets/images/h_a_test.png")),
    KanaViewerContent(
        id: 109,
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: "mu.png",
        romajiImageUrl: "rmu.png",
        strokesNumber: 3,
        kanaType: KanaType.katakana,
        userKana: Image.asset("lib/assets/images/h_a_test.png")),
  ]),
  WordViewerContent(id: 215, text: "サラダ", imageUrl: "salad.png", kanas: [
    KanaViewerContent(
        id: 87,
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: "sa.png",
        romajiImageUrl: "rsa.png",
        strokesNumber: 3,
        kanaType: KanaType.katakana,
        userKana: Image.asset("lib/assets/images/h_a_test.png")),
    KanaViewerContent(
        id: 115,
        status: KanaViewerStatus.showCorrect,
        kanaImageUrl: "ra.png",
        romajiImageUrl: "rra.png",
        strokesNumber: 2,
        kanaType: KanaType.katakana,
        userKana: Image.asset("lib/assets/images/h_a_test.png")),
    KanaViewerContent(
        id: 133,
        status: KanaViewerStatus.showWrong,
        kanaImageUrl: "da.png",
        romajiImageUrl: "rda.png",
        strokesNumber: 5,
        kanaType: KanaType.katakana,
        userKana: Image.asset("lib/assets/images/h_a_test.png")),
  ]),
];
