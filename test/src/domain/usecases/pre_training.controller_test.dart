import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/repositories/kana_type.interface.dart';
import 'package:kana_plus_plus/src/domain/repositories/quantity_of_words.interface.dart';
import 'package:kana_plus_plus/src/domain/repositories/show_hint.interface.dart';
import 'package:kana_plus_plus/src/domain/usecases/pre_training.controller.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final showHintRepository = ShowHintRepositoryMock();
  final kanaTypeRepository = KanaTypeRepositoryMock();
  final quantityOfWordsRepository = QuantityOfWordsRepositoryMock();
  final controller = PreTrainingController(
    showHintRepository: showHintRepository,
    kanaTypeRepository: kanaTypeRepository,
    quantityOfWordsRepository: quantityOfWordsRepository,
  );

  group("show hint", () {
    test("must return the show hint value from repository", () {
      when(() => showHintRepository.isShowHint()).thenAnswer((_) => false);

      final result = controller.isShowHint();

      verify(() => showHintRepository.isShowHint()).called(1);
      expect(result, false);
    });
    test("must return the show hint icon url", () {
      controller.showHint = true;

      final result = controller.getShowHintIconUrl();

      expect(result, IconUrl.showHint);
    });
    test("must return the not show hint icon url", () {
      controller.showHint = false;

      final result = controller.getShowHintIconUrl();

      expect(result, IconUrl.notShowHint);
    });
  });
  group("kana type", () {
    test("must return the kana type from repository", () {
      when(() => kanaTypeRepository.getKanaType())
          .thenAnswer((_) => KanaType.hiragana);

      final result = controller.getKanaType();

      verify(() => kanaTypeRepository.getKanaType()).called(1);
      expect(result, KanaType.hiragana);
    });
    test("must return the kana type hiragana icon url", () {
      controller.kanaType = KanaType.hiragana;

      final result = controller.getKanaTypeIconUrl();

      expect(result, IconUrl.hiragana);
    });
    test("must return the kana type katakana icon url", () {
      controller.kanaType = KanaType.katakana;

      final result = controller.getKanaTypeIconUrl();

      expect(result, IconUrl.katakana);
    });
    test("must return the kana type both icon url", () {
      controller.kanaType = KanaType.both;

      final result = controller.getKanaTypeIconUrl();

      expect(result, IconUrl.both);
    });
    test("must return the writing hand data", () {
      final result = controller.getKanaTypeData();

      expect(result.length, 3);
      expect(result[0].type, KanaType.hiragana);
      expect(result[0].iconUrl, IconUrl.hiragana);
      expect(result[1].type, KanaType.katakana);
      expect(result[1].iconUrl, IconUrl.katakana);
      expect(result[2].type, KanaType.both);
      expect(result[2].iconUrl, IconUrl.both);
    });
  });
  group("kana type", () {
    test("must return the quantity from repository", () {
      when(() => quantityOfWordsRepository.getQuantityOfWords())
          .thenAnswer((_) => 7);

      final result = controller.getQuantityOfWords();

      verify(() => quantityOfWordsRepository.getQuantityOfWords()).called(1);
      expect(result, 7);
    });
    test("must return the quantity of cards icon url", () {
      final result = controller.getQuantityOfWordsIconUrl();

      expect(result, IconUrl.quantityOfWords);
    });
    test("must return the minimum quantity of cards", () {
      final result = controller.getMinimumQuantityOfWords();

      expect(result, Default.minimumTrainingCards.toDouble());
    });
    test("must return the maximum quantity of cards", () {
      final result = controller.getMaximumQuantityOfWords();

      expect(result, Default.maximumTrainingCards.toDouble());
    });
  });
}

class ShowHintRepositoryMock extends Mock implements IShowHintRepository {}

class KanaTypeRepositoryMock extends Mock implements IKanaTypeRepository {}

class QuantityOfWordsRepositoryMock extends Mock
    implements IQuantityOfWordsRepository {}
