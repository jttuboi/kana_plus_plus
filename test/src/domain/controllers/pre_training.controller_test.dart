import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/core/kana_type.dart';
import 'package:kana_plus_plus/src/domain/repositories/kana_type.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/quantity_of_words.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/show_hint.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/controllers/pre_training.controller.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late IShowHintRepository showHintRepository;
  late IKanaTypeRepository kanaTypeRepository;
  late IQuantityOfWordsRepository quantityOfWordsRepository;

  setUp(() {
    showHintRepository = ShowHintRepositoryMock();
    kanaTypeRepository = KanaTypeRepositoryMock();
    quantityOfWordsRepository = QuantityOfWordsRepositoryMock();
  });

  PreTrainingController _startController({bool showHint = false, KanaType kanaType = KanaType.none, int quantityOfWords = 0}) {
    when(() => showHintRepository.isShowHint()).thenAnswer((_) => showHint);
    when(() => kanaTypeRepository.getKanaType()).thenAnswer((_) => kanaType);
    when(() => quantityOfWordsRepository.getQuantityOfWords()).thenAnswer((_) => quantityOfWords);
    return PreTrainingController(
      showHintRepository: showHintRepository,
      kanaTypeRepository: kanaTypeRepository,
      quantityOfWordsRepository: quantityOfWordsRepository,
    );
  }

  group('show hint', () {
    test('must return the show hint value from repository', () {
      // ignore: avoid_redundant_argument_values
      final controller = _startController(showHint: false);

      final result = controller.showHint;

      verify(() => showHintRepository.isShowHint()).called(1);
      expect(result, false);
    });
    test('must return the show hint icon url', () {
      final controller = _startController(showHint: true);

      final result = controller.showHintIconUrl;

      expect(result, IconUrl.showHint);
    });
    test('must return the not show hint icon url', () {
      // ignore: avoid_redundant_argument_values
      final controller = _startController(showHint: false);

      final result = controller.showHintIconUrl;

      expect(result, IconUrl.notShowHint);
    });
  });
  group('kana type', () {
    test('must return the kana type from repository', () {
      final controller = _startController(kanaType: KanaType.hiragana);

      final result = controller.kanaType;

      verify(() => kanaTypeRepository.getKanaType()).called(1);
      expect(result, KanaType.hiragana);
    });
    test('must return the kana type hiragana icon url', () {
      final controller = _startController(kanaType: KanaType.hiragana);

      final result = controller.kanaTypeIconUrl;

      expect(result, IconUrl.hiragana);
    });
    test('must return the kana type katakana icon url', () {
      final controller = _startController(kanaType: KanaType.katakana);

      final result = controller.kanaTypeIconUrl;

      expect(result, IconUrl.katakana);
    });
    test('must return the kana type both icon url', () {
      final controller = _startController(kanaType: KanaType.both);

      final result = controller.kanaTypeIconUrl;

      expect(result, IconUrl.both);
    });
    test('must return the writing hand data', () {
      final controller = _startController();

      final result = controller.kanaTypeData;

      expect(result.length, 3);
      expect(result[0].type, KanaType.hiragana);
      expect(result[0].iconUrl, IconUrl.hiragana);
      expect(result[1].type, KanaType.katakana);
      expect(result[1].iconUrl, IconUrl.katakana);
      expect(result[2].type, KanaType.both);
      expect(result[2].iconUrl, IconUrl.both);
    });
  });
  group('quantity of words', () {
    test('must return the quantity from repository', () {
      final controller = _startController(quantityOfWords: 7);

      final result = controller.quantityOfWords;

      verify(() => quantityOfWordsRepository.getQuantityOfWords()).called(1);
      expect(result, 7);
    });
  });
}

class ShowHintRepositoryMock extends Mock implements IShowHintRepository {}

class KanaTypeRepositoryMock extends Mock implements IKanaTypeRepository {}

class QuantityOfWordsRepositoryMock extends Mock implements IQuantityOfWordsRepository {}
