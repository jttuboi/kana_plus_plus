import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/enums/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/repositories/writing_hand.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';
import 'package:mocktail/mocktail.dart';

// TODO fazer esses testes
//   List<List<Offset>> get strokesNormalized => []; // aqui deve procurar pelos strokes normalizados
//   int get generateKanaId => 0; // aqui deve procurar pelo kana (kanaType)

void main() {
  late IWritingHandRepository writingHandRepository;
  late WriterController controller;

  setUpAll(() {
    writingHandRepository = WritingHandRepositoryMock();
    controller = WriterController(
      writingHandRepository: writingHandRepository,
      showHint: true,
    );
  });

  group("writer controller tests", () {
    test("start writer controller", () {
      final repository1 = WritingHandRepositoryMock();
      final controller1 = WriterController(writingHandRepository: repository1, showHint: true);

      expect(controller1.writingHandRepository, repository1);
      expect(controller1.showHint, isTrue);

      final repository2 = WritingHandRepositoryMock();
      final controller2 = WriterController(writingHandRepository: repository2, showHint: false);

      expect(controller2.writingHandRepository, repository2);
      expect(controller2.showHint, isFalse);
    });
    test("must give new values to writer", () {
      controller.strokes.addAll(threeStrokesSample);
      controller.maxStrokes = 3;
      controller.kanaType = KanaType.katakana;

      controller.updateWriter(5, "src/a.png", KanaType.hiragana);

      expect(controller.strokes.length, 0);
      expect(controller.kanaHintImageUrl, "src/a.png");
      expect(controller.maxStrokes, 5);
      expect(controller.kanaType, KanaType.hiragana);
    });
  });
  group("icons url", () {
    test("must return eraser icon url", () {
      expect(controller.eraserIconUrl, IconUrl.eraser);
    });
    test("must return undo icon url", () {
      expect(controller.undoIconUrl, IconUrl.undo);
    });
    test("must return square image url", () {
      expect(controller.squareImageUrl, ImageUrl.square);
    });
  });
  group("manipulate strokes", () {
    test("must add new stroke to strokes", () {
      controller.strokes = [];
      const stroke1 = [Offset(1, 3), Offset(5, 3)];
      const stroke2 = [Offset(2, 8), Offset(8, 1)];

      controller.addStroke(stroke1);

      expect(controller.strokes.length, 1);
      expect(controller.strokes[0], stroke1);

      controller.addStroke(stroke2);

      expect(controller.strokes.length, 2);
      expect(controller.strokes[0], stroke1);
      expect(controller.strokes[1], stroke2);
    });
    test("must add an reduced stroke to strokes", () {
      controller.strokes = [];

      controller.addStroke(noStroke);

      expect(controller.strokes.length, 1);
      expect(controller.strokes[0], noStrokeResult);

      controller.addStroke(shiStroke);

      expect(controller.strokes.length, 2);
      expect(controller.strokes[0], noStrokeResult);
      expect(controller.strokes[1], shiStrokeResult);
    });
    test("must return bool if is the last stroke wrote", () {
      controller.strokes = threeStrokesSample.toList();
      controller.maxStrokes = 3;

      expect(controller.isTheLastStroke, isTrue);
    });
    test("must return bool if is not the last stroke wrote", () {
      controller.strokes = threeStrokesSample.toList();
      controller.maxStrokes = 4;

      expect(controller.isTheLastStroke, isFalse);
    });
    test("must clear strokes", () {
      controller.strokes = threeStrokesSample.toList();

      controller.clearStrokes();

      expect(controller.strokes, isEmpty);
    });
    test("must undo stroke", () {
      controller.strokes = fourStrokesSample.toList();

      controller.undoTheLastStroke();

      expect(controller.strokes.length, 3);
      expect(controller.strokes[0], fourStrokesSample[0]);
      expect(controller.strokes[1], fourStrokesSample[1]);
      expect(controller.strokes[2], fourStrokesSample[2]);
    });
    test("doesn't undo if it doesn't have any stroke to undo", () {
      controller.strokes = [];

      controller.undoTheLastStroke();

      expect(controller.strokes, isEmpty);
    });
  });
  test("must return the writing hand from repository", () {
    when(() => writingHandRepository.getWritingHandSelected()).thenAnswer((_) => WritingHand.left);

    final result = controller.writingHand;

    verify(() => writingHandRepository.getWritingHandSelected()).called(1);
    expect(result, WritingHand.left);
  });
  group("reduce path", () {
    test("must return empty array when path is empty", () {
      final path = <Offset>[];
      final result = controller.reducePath(path);

      expect(result, isEmpty);
    });
    test("must return the same path when the quantity is <= 10", () {
      final path = [
        const Offset(3, 2),
        const Offset(5, 4),
        const Offset(2, 7),
        const Offset(5, 5),
        const Offset(7, 3),
      ];
      final result = controller.reducePath(path);

      expect(result, path);
    });
    test("must return the same path when the quantity is <= 10", () {
      final path = [
        const Offset(2, 3),
        const Offset(1, 5),
        const Offset(4, 3),
        const Offset(7, 4),
        const Offset(9, 7),
        const Offset(3, 2),
        const Offset(5, 4),
        const Offset(2, 7),
        const Offset(5, 5),
        const Offset(7, 3),
      ];
      final result = controller.reducePath(path);

      expect(result, path);
    });
    test("must return the same path when the quantity is <= 20", () {
      const path = [
        Offset(2, 3),
        Offset(1, 5),
        Offset(4, 3),
        Offset(7, 4),
        Offset(9, 7),
        Offset(3, 8),
        Offset(5, 6),
        Offset(2, 5),
        Offset(5, 3),
        Offset(7, 6),
        Offset(8, 2),
        Offset(4, 8),
        Offset(7, 6),
        Offset(1, 4),
        Offset(5, 9),
        Offset(7, 8),
        Offset(3, 5),
        Offset(7, 2),
        Offset(3, 7),
        Offset(2, 6),
      ];
      final result = controller.reducePath(path);

      expect(result, path);
    });
    test("must return reduced path for horizontal line sample", () {
      final result = controller.reducePath(horizontalLineStroke);
      expect(result, horizontalLineStrokeResult);
    });
    test("must return reduced path for shi hiragana sample", () {
      final result = controller.reducePath(shiStroke);
      expect(result, shiStrokeResult);
    });
    test("must return reduced path for no hiragana sample", () {
      final result = controller.reducePath(noStroke);
      expect(result, noStrokeResult);
    });
  });
  group("normalized strokes", () {
    test("must return strokes normalized", () {
      controller.strokes = [shiStrokeResult, noStrokeResult];
      const startLocationOfSquareUsedForDraw = 0.0;
      const endLocationOfSquareUsedForDraw = 206.7;

      final result = controller.strokesNormalized(startLocationOfSquareUsedForDraw, endLocationOfSquareUsedForDraw);

      expect(result, [shiStrokeResultNormalized, noStrokeResultNormalized]);
    });
  });
}

class WritingHandRepositoryMock extends Mock implements IWritingHandRepository {}

final threeStrokesSample = [
  const [Offset(0, 1), Offset(1, 2)],
  const [Offset(2, 1), Offset(7, 4)],
  const [Offset(7, 3), Offset(5, 8)],
];

final fourStrokesSample = [
  const [Offset(0, 3), Offset(5, 8)],
  const [Offset(2, 8), Offset(6, 4)],
  const [Offset(7, 4), Offset(6, 2)],
  const [Offset(0, 8), Offset(1, 3)],
];

const horizontalLineStroke = [
  Offset(89.4, 133.8),
  Offset(90.5, 133.8),
  Offset(91.6, 133.8),
  Offset(92.3, 133.8),
  Offset(93.4, 133.8),
  Offset(94.5, 133.8),
  Offset(95.6, 133.8),
  Offset(96.7, 133.8),
  Offset(97.8, 133.8),
  Offset(98.9, 133.8),
  Offset(100.0, 133.8),
  Offset(101.1, 133.8),
  Offset(102.2, 133.8),
  Offset(102.9, 133.8),
  Offset(104.0, 133.8),
  Offset(105.1, 133.8),
  Offset(106.2, 133.8),
  Offset(107.3, 133.8),
  Offset(107.3, 134.9),
  Offset(108.3, 134.9),
  Offset(109.4, 134.9),
  Offset(110.5, 134.9),
  Offset(111.6, 134.9),
  Offset(112.4, 134.9),
  Offset(113.4, 134.9),
  Offset(113.4, 135.6),
  Offset(114.5, 135.6),
  Offset(115.6, 135.6),
  Offset(116.7, 135.6),
  Offset(117.8, 135.6),
  Offset(118.9, 135.6),
  Offset(120.0, 135.6),
  Offset(121.1, 135.6),
  Offset(122.2, 135.6),
  Offset(122.9, 135.6),
];

const horizontalLineStrokeResult = [
  Offset(89.4, 133.8),
  Offset(107.3, 133.8),
  Offset(107.3, 134.9),
  Offset(122.9, 135.6),
];

const shiStroke = [
  Offset(78.9, 49.4),
  Offset(78.9, 50.5),
  Offset(78.9, 51.6),
  Offset(78.9, 52.7),
  Offset(78.9, 53.8),
  Offset(78.9, 54.9),
  Offset(78.9, 56.0),
  Offset(78.9, 57.1),
  Offset(80.0, 57.1),
  Offset(80.0, 58.2),
  Offset(80.0, 58.9),
  Offset(80.0, 60.0),
  Offset(80.0, 61.1),
  Offset(80.0, 62.2),
  Offset(81.1, 62.2),
  Offset(81.1, 63.2),
  Offset(81.1, 64.3),
  Offset(81.1, 65.4),
  Offset(81.1, 66.5),
  Offset(81.1, 67.6),
  Offset(81.1, 68.4),
  Offset(81.1, 69.4),
  Offset(81.1, 70.5),
  Offset(81.1, 71.6),
  Offset(81.1, 72.7),
  Offset(81.1, 73.8),
  Offset(81.1, 74.9),
  Offset(82.2, 74.9),
  Offset(82.2, 76.0),
  Offset(82.2, 77.1),
  Offset(82.2, 77.8),
  Offset(82.9, 77.8),
  Offset(82.9, 78.9),
  Offset(82.9, 80.0),
  Offset(82.9, 81.1),
  Offset(82.9, 82.2),
  Offset(82.9, 83.3),
  Offset(82.9, 84.3),
  Offset(84.0, 84.3),
  Offset(84.0, 85.4),
  Offset(84.0, 86.5),
  Offset(84.0, 87.3),
  Offset(84.0, 88.3),
  Offset(84.0, 89.4),
  Offset(84.0, 90.5),
  Offset(84.0, 91.6),
  Offset(84.0, 92.7),
  Offset(84.0, 93.8),
  Offset(84.0, 94.9),
  Offset(85.1, 94.9),
  Offset(85.1, 96.0),
  Offset(85.1, 96.7),
  Offset(85.1, 97.8),
  Offset(85.1, 98.9),
  Offset(85.1, 100.0),
  Offset(85.1, 101.1),
  Offset(85.1, 102.2),
  Offset(85.1, 103.2),
  Offset(86.2, 103.2),
  Offset(86.2, 104.3),
  Offset(86.2, 105.4),
  Offset(86.2, 106.5),
  Offset(86.2, 107.2),
  Offset(86.2, 108.3),
  Offset(86.2, 109.4),
  Offset(86.2, 110.5),
  Offset(86.2, 111.6),
  Offset(86.2, 112.7),
  Offset(86.2, 113.8),
  Offset(86.2, 114.9),
  Offset(86.2, 116.0),
  Offset(86.2, 116.7),
  Offset(86.2, 117.8),
  Offset(86.2, 118.9),
  Offset(86.2, 120.0),
  Offset(86.2, 121.1),
  Offset(86.2, 122.2),
  Offset(86.2, 123.3),
  Offset(87.3, 124.3),
  Offset(87.3, 125.4),
  Offset(87.3, 126.2),
  Offset(87.3, 127.3),
  Offset(88.4, 128.3),
  Offset(88.4, 129.4),
  Offset(88.4, 130.5),
  Offset(88.4, 131.6),
  Offset(88.4, 132.7),
  Offset(88.4, 133.8),
  Offset(88.4, 134.9),
  Offset(88.4, 135.6),
  Offset(88.4, 136.7),
  Offset(88.4, 137.8),
  Offset(88.4, 138.9),
  Offset(88.4, 140.0),
  Offset(88.4, 141.1),
  Offset(88.4, 142.2),
  Offset(88.4, 143.2),
  Offset(88.4, 144.3),
  Offset(88.4, 145.1),
  Offset(89.4, 145.1),
  Offset(89.4, 146.2),
  Offset(90.5, 146.2),
  Offset(90.5, 147.2),
  Offset(90.5, 148.3),
  Offset(90.5, 149.4),
  Offset(91.6, 149.4),
  Offset(91.6, 150.5),
  Offset(92.3, 150.5),
  Offset(93.4, 150.5),
  Offset(93.4, 151.6),
  Offset(94.5, 152.7),
  Offset(94.5, 153.8),
  Offset(95.6, 153.8),
  Offset(95.6, 154.5),
  Offset(96.7, 154.5),
  Offset(97.8, 154.5),
  Offset(97.8, 155.6),
  Offset(98.9, 155.6),
  Offset(100.0, 155.6),
  Offset(101.1, 155.6),
  Offset(101.1, 156.7),
  Offset(102.2, 156.7),
  Offset(102.2, 157.8),
  Offset(102.9, 157.8),
  Offset(102.9, 158.9),
  Offset(104.0, 158.9),
  Offset(105.1, 158.9),
  Offset(106.2, 158.9),
  Offset(107.3, 160.0),
  Offset(108.3, 160.0),
  Offset(108.3, 161.1),
  Offset(109.4, 161.1),
  Offset(109.4, 162.1),
  Offset(110.5, 162.1),
  Offset(111.6, 162.1),
  Offset(112.4, 162.1),
  Offset(113.4, 162.1),
  Offset(114.5, 162.1),
  Offset(114.5, 163.2),
  Offset(115.6, 163.2),
  Offset(116.7, 163.2),
  Offset(117.8, 163.2),
  Offset(118.9, 164.3),
  Offset(120.0, 164.3),
  Offset(121.1, 164.3),
  Offset(122.2, 164.3),
  Offset(122.9, 164.3),
  Offset(124.0, 164.3),
  Offset(125.1, 164.3),
  Offset(126.2, 164.3),
  Offset(127.3, 164.3),
  Offset(128.4, 164.3),
  Offset(128.4, 165.1),
  Offset(129.4, 165.1),
  Offset(130.5, 165.1),
  Offset(131.6, 165.1),
  Offset(132.4, 165.1),
  Offset(133.4, 165.1),
  Offset(134.5, 165.1),
  Offset(135.6, 165.1),
  Offset(136.7, 165.1),
  Offset(137.8, 165.1),
  Offset(138.9, 165.1),
  Offset(140.0, 165.1),
  Offset(141.1, 165.1),
  Offset(142.2, 165.1),
  Offset(142.2, 166.1),
  Offset(142.9, 166.1),
  Offset(144.0, 166.1),
  Offset(145.1, 166.1),
  Offset(146.2, 166.1),
  Offset(147.3, 166.1),
  Offset(148.4, 166.1),
  Offset(149.4, 166.1),
  Offset(150.5, 166.1),
  Offset(151.6, 166.1),
  Offset(152.3, 166.1),
  Offset(153.4, 166.1),
  Offset(154.5, 166.1),
  Offset(155.6, 166.1),
  Offset(156.7, 166.1),
  Offset(157.8, 166.1),
  Offset(158.9, 166.1),
  Offset(160.0, 166.1),
  Offset(161.1, 166.1),
  Offset(162.2, 166.1),
  Offset(162.9, 166.1),
  Offset(165.1, 166.1),
  Offset(165.1, 165.1),
  Offset(166.2, 165.1),
  Offset(167.3, 165.1),
  Offset(168.3, 165.1),
  Offset(168.3, 164.3),
  Offset(169.4, 164.3),
  Offset(170.5, 164.3),
  Offset(171.6, 164.3),
  Offset(172.3, 164.3),
  Offset(173.4, 164.3),
  Offset(174.5, 164.3),
  Offset(175.6, 164.3),
];

const shiStrokeResult = [
  Offset(78.9, 49.4),
  Offset(86.2, 103.2),
  Offset(88.4, 145.1),
  Offset(90.5, 149.4),
  Offset(95.6, 154.5),
  Offset(101.1, 155.6),
  Offset(102.9, 158.9),
  Offset(118.9, 164.3),
  Offset(142.2, 166.1),
  Offset(175.6, 164.3),
];

const shiStrokeResultNormalized = [
  Offset(0.3817126269956459, 0.2389937106918239),
  Offset(0.417029511369134, 0.49927431059506533),
  Offset(0.42767295597484284, 0.7019835510401549),
  Offset(0.4378326076439284, 0.7227866473149492),
  Offset(0.4625060474117078, 0.7474600870827286),
  Offset(0.48911465892597966, 0.752781809385583),
  Offset(0.497822931785196, 0.7687469762941461),
  Offset(0.575229801644896, 0.7948717948717949),
  Offset(0.6879535558780842, 0.8035800677310111),
  Offset(0.8495403967102081, 0.7948717948717949),
];

const noStroke = [
  Offset(121.1, 96.0),
  Offset(121.1, 96.7),
  Offset(121.1, 97.8),
  Offset(121.1, 98.9),
  Offset(121.1, 100.0),
  Offset(121.1, 101.1),
  Offset(121.1, 102.2),
  Offset(121.1, 103.2),
  Offset(121.1, 104.3),
  Offset(121.1, 105.4),
  Offset(121.1, 106.5),
  Offset(121.1, 107.2),
  Offset(121.1, 108.3),
  Offset(121.1, 109.4),
  Offset(121.1, 110.5),
  Offset(121.1, 111.6),
  Offset(121.1, 112.7),
  Offset(121.1, 113.8),
  Offset(121.1, 114.9),
  Offset(121.1, 116.0),
  Offset(121.1, 116.7),
  Offset(121.1, 117.8),
  Offset(121.1, 118.9),
  Offset(121.1, 120.0),
  Offset(121.1, 121.1),
  Offset(121.1, 122.2),
  Offset(121.1, 123.3),
  Offset(121.1, 124.3),
  Offset(121.1, 125.4),
  Offset(121.1, 126.2),
  Offset(121.1, 127.3),
  Offset(121.1, 128.3),
  Offset(121.1, 129.4),
  Offset(121.1, 130.5),
  Offset(121.1, 131.6),
  Offset(121.1, 132.7),
  Offset(121.1, 133.8),
  Offset(121.1, 134.9),
  Offset(121.1, 135.6),
  Offset(121.1, 136.7),
  Offset(121.1, 137.8),
  Offset(121.1, 138.9),
  Offset(121.1, 140.0),
  Offset(121.1, 141.1),
  Offset(120.0, 141.1),
  Offset(120.0, 142.2),
  Offset(118.9, 143.2),
  Offset(118.9, 144.3),
  Offset(118.9, 145.1),
  Offset(118.9, 146.2),
  Offset(118.9, 147.2),
  Offset(118.9, 148.3),
  Offset(118.9, 149.4),
  Offset(118.9, 150.5),
  Offset(117.8, 150.5),
  Offset(117.8, 151.6),
  Offset(117.8, 152.7),
  Offset(116.7, 152.7),
  Offset(116.7, 153.8),
  Offset(115.6, 153.8),
  Offset(115.6, 154.5),
  Offset(114.5, 154.5),
  Offset(114.5, 155.6),
  Offset(114.5, 156.7),
  Offset(113.4, 156.7),
  Offset(113.4, 157.8),
  Offset(113.4, 158.9),
  Offset(112.4, 158.9),
  Offset(112.4, 160.0),
  Offset(112.4, 161.1),
  Offset(111.6, 161.1),
  Offset(111.6, 162.1),
  Offset(110.5, 162.1),
  Offset(110.5, 163.2),
  Offset(109.4, 163.2),
  Offset(109.4, 164.3),
  Offset(108.3, 165.1),
  Offset(108.3, 166.1),
  Offset(107.3, 166.1),
  Offset(106.2, 166.1),
  Offset(106.2, 167.3),
  Offset(105.1, 167.3),
  Offset(105.1, 168.3),
  Offset(104.0, 169.4),
  Offset(102.9, 169.4),
  Offset(102.9, 170.5),
  Offset(102.2, 170.5),
  Offset(101.1, 171.6),
  Offset(101.1, 172.7),
  Offset(100.0, 172.7),
  Offset(100.0, 173.8),
  Offset(98.9, 173.8),
  Offset(97.8, 173.8),
  Offset(96.7, 173.8),
  Offset(96.7, 174.5),
  Offset(95.6, 174.5),
  Offset(94.5, 174.5),
  Offset(93.4, 174.5),
  Offset(93.4, 175.6),
  Offset(92.3, 175.6),
  Offset(91.6, 175.6),
  Offset(91.6, 176.7),
  Offset(90.5, 176.7),
  Offset(89.4, 176.7),
  Offset(88.4, 176.7),
  Offset(87.3, 176.7),
  Offset(87.3, 177.8),
  Offset(86.2, 177.8),
  Offset(85.1, 177.8),
  Offset(84.0, 177.8),
  Offset(82.9, 177.8),
  Offset(82.2, 177.8),
  Offset(81.1, 177.8),
  Offset(81.1, 176.7),
  Offset(80.0, 176.7),
  Offset(78.9, 176.7),
  Offset(78.9, 175.6),
  Offset(77.8, 175.6),
  Offset(77.8, 174.5),
  Offset(76.7, 174.5),
  Offset(75.6, 174.5),
  Offset(75.6, 173.8),
  Offset(74.5, 172.7),
  Offset(74.5, 171.6),
  Offset(73.4, 171.6),
  Offset(72.4, 170.5),
  Offset(71.6, 170.5),
  Offset(71.6, 169.4),
  Offset(71.6, 168.3),
  Offset(71.6, 167.3),
  Offset(70.5, 167.3),
  Offset(70.5, 166.1),
  Offset(70.5, 165.1),
  Offset(70.5, 164.3),
  Offset(69.4, 164.3),
  Offset(69.4, 163.2),
  Offset(69.4, 162.1),
  Offset(68.4, 162.1),
  Offset(68.4, 161.1),
  Offset(68.4, 160.0),
  Offset(68.4, 158.9),
  Offset(68.4, 157.8),
  Offset(68.4, 156.7),
  Offset(67.3, 155.6),
  Offset(66.2, 155.6),
  Offset(66.2, 154.5),
  Offset(66.2, 153.8),
  Offset(66.2, 152.7),
  Offset(66.2, 151.6),
  Offset(65.1, 151.6),
  Offset(65.1, 150.5),
  Offset(65.1, 149.4),
  Offset(65.1, 148.3),
  Offset(65.1, 147.2),
  Offset(65.1, 146.2),
  Offset(65.1, 145.1),
  Offset(65.1, 144.3),
  Offset(65.1, 143.2),
  Offset(65.1, 142.2),
  Offset(65.1, 141.1),
  Offset(65.1, 140.0),
  Offset(65.1, 138.9),
  Offset(65.1, 137.8),
  Offset(65.1, 136.7),
  Offset(65.1, 135.6),
  Offset(65.1, 134.9),
  Offset(65.1, 133.8),
  Offset(65.1, 132.7),
  Offset(65.1, 131.6),
  Offset(65.1, 130.5),
  Offset(65.1, 129.4),
  Offset(65.1, 128.3),
  Offset(66.2, 128.3),
  Offset(66.2, 127.3),
  Offset(66.2, 126.2),
  Offset(67.3, 126.2),
  Offset(67.3, 125.4),
  Offset(67.3, 124.3),
  Offset(68.4, 124.3),
  Offset(68.4, 123.3),
  Offset(69.4, 123.3),
  Offset(69.4, 122.2),
  Offset(69.4, 121.1),
  Offset(70.5, 121.1),
  Offset(70.5, 120.0),
  Offset(71.6, 120.0),
  Offset(71.6, 118.9),
  Offset(72.4, 118.9),
  Offset(72.4, 117.8),
  Offset(73.4, 116.7),
  Offset(73.4, 116.0),
  Offset(74.5, 116.0),
  Offset(75.6, 114.9),
  Offset(76.7, 114.9),
  Offset(76.7, 113.8),
  Offset(76.7, 112.7),
  Offset(77.8, 112.7),
  Offset(77.8, 111.6),
  Offset(78.9, 111.6),
  Offset(78.9, 110.5),
  Offset(80.0, 110.5),
  Offset(81.1, 110.5),
  Offset(81.1, 109.4),
  Offset(82.2, 109.4),
  Offset(82.2, 108.3),
  Offset(82.9, 107.2),
  Offset(84.0, 106.5),
  Offset(85.1, 106.5),
  Offset(86.2, 106.5),
  Offset(86.2, 105.4),
  Offset(86.2, 104.3),
  Offset(87.3, 104.3),
  Offset(87.3, 103.2),
  Offset(88.4, 103.2),
  Offset(89.4, 103.2),
  Offset(90.5, 102.2),
  Offset(90.5, 101.1),
  Offset(91.6, 101.1),
  Offset(92.3, 100.0),
  Offset(93.4, 100.0),
  Offset(93.4, 98.9),
  Offset(94.5, 98.9),
  Offset(95.6, 98.9),
  Offset(95.6, 97.8),
  Offset(96.7, 97.8),
  Offset(97.8, 97.8),
  Offset(98.9, 96.7),
  Offset(100.0, 96.7),
  Offset(101.1, 96.7),
  Offset(102.2, 96.7),
  Offset(102.9, 96.0),
  Offset(104.0, 96.0),
  Offset(104.0, 94.9),
  Offset(105.1, 94.9),
  Offset(106.2, 94.9),
  Offset(106.2, 93.8),
  Offset(107.3, 93.8),
  Offset(108.3, 93.8),
  Offset(109.4, 93.8),
  Offset(110.5, 93.8),
  Offset(111.6, 93.8),
  Offset(112.4, 93.8),
  Offset(112.4, 92.7),
  Offset(113.4, 92.7),
  Offset(114.5, 92.7),
  Offset(115.6, 92.7),
  Offset(116.7, 92.7),
  Offset(117.8, 92.7),
  Offset(118.9, 92.7),
  Offset(120.0, 92.7),
  Offset(121.1, 92.7),
  Offset(122.2, 92.7),
  Offset(122.9, 92.7),
  Offset(124.0, 92.7),
  Offset(125.1, 92.7),
  Offset(126.2, 92.7),
  Offset(127.3, 92.7),
  Offset(128.4, 92.7),
  Offset(129.4, 92.7),
  Offset(130.5, 92.7),
  Offset(130.5, 93.8),
  Offset(131.6, 93.8),
  Offset(132.4, 93.8),
  Offset(133.4, 94.9),
  Offset(134.5, 94.9),
  Offset(134.5, 96.0),
  Offset(135.6, 96.0),
  Offset(136.7, 96.0),
  Offset(137.8, 96.0),
  Offset(138.9, 96.7),
  Offset(140.0, 96.7),
  Offset(141.1, 97.8),
  Offset(142.2, 97.8),
  Offset(142.9, 97.8),
  Offset(144.0, 97.8),
  Offset(144.0, 98.9),
  Offset(145.1, 98.9),
  Offset(146.2, 98.9),
  Offset(146.2, 100.0),
  Offset(147.3, 100.0),
  Offset(147.3, 101.1),
  Offset(148.4, 101.1),
  Offset(149.4, 101.1),
  Offset(149.4, 102.2),
  Offset(150.5, 102.2),
  Offset(151.6, 102.2),
  Offset(151.6, 103.2),
  Offset(151.6, 104.3),
  Offset(152.3, 104.3),
  Offset(152.3, 105.4),
  Offset(153.4, 105.4),
  Offset(154.5, 106.5),
  Offset(154.5, 107.2),
  Offset(155.6, 107.2),
  Offset(155.6, 108.3),
  Offset(156.7, 108.3),
  Offset(156.7, 109.4),
  Offset(157.8, 109.4),
  Offset(157.8, 110.5),
  Offset(158.9, 110.5),
  Offset(158.9, 111.6),
  Offset(160.0, 111.6),
  Offset(160.0, 112.7),
  Offset(160.0, 113.8),
  Offset(161.1, 113.8),
  Offset(161.1, 114.9),
  Offset(161.1, 116.0),
  Offset(161.1, 116.7),
  Offset(162.2, 117.8),
  Offset(162.9, 118.9),
  Offset(162.9, 120.0),
  Offset(164.0, 120.0),
  Offset(164.0, 121.1),
  Offset(164.0, 122.2),
  Offset(164.0, 123.3),
  Offset(164.0, 124.3),
  Offset(165.1, 124.3),
  Offset(165.1, 125.4),
  Offset(165.1, 126.2),
  Offset(165.1, 127.3),
  Offset(165.1, 128.3),
  Offset(166.2, 128.3),
  Offset(166.2, 129.4),
  Offset(166.2, 130.5),
  Offset(166.2, 131.6),
  Offset(166.2, 132.7),
  Offset(167.3, 132.7),
  Offset(167.3, 133.8),
  Offset(168.3, 134.9),
  Offset(168.3, 135.6),
  Offset(168.3, 136.7),
  Offset(168.3, 137.8),
  Offset(168.3, 138.9),
  Offset(169.4, 138.9),
  Offset(169.4, 140.0),
  Offset(169.4, 141.1),
  Offset(169.4, 142.2),
  Offset(169.4, 143.2),
  Offset(169.4, 144.3),
  Offset(169.4, 145.1),
  Offset(169.4, 146.2),
  Offset(169.4, 147.2),
  Offset(169.4, 148.3),
  Offset(169.4, 149.4),
  Offset(169.4, 150.5),
  Offset(169.4, 151.6),
  Offset(169.4, 152.7),
  Offset(169.4, 153.8),
  Offset(169.4, 154.5),
  Offset(169.4, 155.6),
  Offset(169.4, 156.7),
  Offset(169.4, 157.8),
  Offset(169.4, 158.9),
  Offset(169.4, 160.0),
  Offset(169.4, 161.1),
  Offset(169.4, 162.1),
  Offset(168.3, 163.2),
  Offset(168.3, 164.3),
  Offset(168.3, 165.1),
  Offset(167.3, 165.1),
  Offset(167.3, 166.1),
  Offset(166.2, 166.1),
  Offset(166.2, 167.3),
  Offset(165.1, 167.3),
  Offset(165.1, 168.3),
  Offset(164.0, 168.3),
  Offset(164.0, 169.4),
  Offset(162.9, 170.5),
  Offset(162.2, 170.5),
  Offset(162.2, 171.6),
  Offset(161.1, 171.6),
  Offset(161.1, 172.7),
  Offset(161.1, 173.8),
  Offset(160.0, 173.8),
  Offset(160.0, 174.5),
  Offset(158.9, 174.5),
  Offset(157.8, 174.5),
];

const noStrokeResult = [
  Offset(121.1, 96.0),
  Offset(121.1, 141.1),
  Offset(118.9, 143.2),
  Offset(118.9, 150.5),
  Offset(114.5, 154.5),
  Offset(112.4, 161.1),
  Offset(100.0, 173.8),
  Offset(87.3, 177.8),
  Offset(81.1, 177.8),
  Offset(71.6, 170.5),
  Offset(68.4, 156.7),
  Offset(65.1, 151.6),
  Offset(65.1, 128.3),
  Offset(69.4, 121.1),
  Offset(78.9, 110.5),
  Offset(95.6, 97.8),
  Offset(112.4, 92.7),
  Offset(130.5, 92.7),
  Offset(151.6, 102.2),
  Offset(152.3, 105.4),
  Offset(160.0, 111.6),
  Offset(164.0, 120.0),
  Offset(169.4, 138.9),
  Offset(169.4, 162.1),
  Offset(161.1, 173.8),
  Offset(157.8, 174.5),
];

const noStrokeResultNormalized = [
  Offset(0.5858732462506048, 0.4644412191582003),
  Offset(0.5858732462506048, 0.6826318335752298),
  Offset(0.575229801644896, 0.6927914852443154),
  Offset(0.575229801644896, 0.7281083696178037),
  Offset(0.5539429124334785, 0.7474600870827286),
  Offset(0.5437832607643929, 0.7793904208998549),
  Offset(0.48379293662312534, 0.8408321238509919),
  Offset(0.4223512336719884, 0.8601838413159169),
  Offset(0.3923560716013546, 0.8601838413159169),
  Offset(0.3463957426221577, 0.8248669569424287),
  Offset(0.3309143686502177, 0.7581035316884374),
  Offset(0.3149492017416546, 0.733430091920658),
  Offset(0.3149492017416546, 0.6207063376874699),
  Offset(0.335752298016449, 0.5858732462506048),
  Offset(0.3817126269956459, 0.5345911949685535),
  Offset(0.4625060474117078, 0.4731494920174166),
  Offset(0.5437832607643929, 0.4484760522496372),
  Offset(0.6313497822931785, 0.4484760522496372),
  Offset(0.733430091920658, 0.4944363812288341),
  Offset(0.73681664247702, 0.5099177552007741),
  Offset(0.7740686985970006, 0.5399129172714079),
  Offset(0.7934204160619256, 0.5805515239477504),
  Offset(0.8195452346395743, 0.6719883889695211),
  Offset(0.8195452346395743, 0.7842283502660862),
  Offset(0.7793904208998549, 0.8408321238509919),
  Offset(0.7634252539912918, 0.8442186744073537),
];
