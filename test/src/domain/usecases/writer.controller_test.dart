import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';

void main() {
  final controller = WriterController();

  group("icons url", () {
    test("must return eraser icon url", () {
      final result = controller.eraserIconUrl;

      expect(result, IconUrl.eraser);
    });
    test("must return undo icon url", () {
      final result = controller.undoIconUrl;

      expect(result, IconUrl.undo);
    });
  });
  group("manipulate strokes", () {
    test("must give new values to writer kana", () {
      controller.strokeNumber = 3;
      controller.maxStrokes = 3;
      controller.currentKanaType = KanaType.katakana;

      controller.updateWriter(5, KanaType.hiragana);

      expect(controller.strokeNumber, 0);
      expect(controller.maxStrokes, 5);
      expect(controller.currentKanaType, KanaType.hiragana);
    });
    test("must clear strokes", () {
      controller.strokeNumber = 3;

      controller.clearStrokes();

      expect(controller.strokeNumber, 0);
    });
    test("must undo stroke", () {
      controller.strokeNumber = 3;

      controller.undoTheLastStroke();

      expect(controller.strokeNumber, 2);
    });
    // test("must process stroke giving points from touch", () {
    //   // TODO criar esse testes mais complexo
    //   // Map<String, dynamic> processStroke(List<Point> points) {
    // });
  });
}
