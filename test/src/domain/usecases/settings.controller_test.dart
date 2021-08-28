import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/enums/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/repositories/dark_theme.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/kana_type.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/language.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/quantity_of_words.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/show_hint.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/writing_hand.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final languageRepository = LanguageRepositoryMock();
  final writingHandRepository = WritingHandRepositoryMock();
  final darkThemeRepository = DarkThemeRepositoryMock();
  final showHintRepository = ShowHintRepositoryMock();
  final kanaTypeRepository = KanaTypeRepositoryMock();
  final quantityOfWordsRepository = QuantityOfWordsRepositoryMock();
  final controller = SettingsController(
    languageRepository: languageRepository,
    writingHandRepository: writingHandRepository,
    darkThemeRepository: darkThemeRepository,
    showHintRepository: showHintRepository,
    kanaTypeRepository: kanaTypeRepository,
    quantityOfWordsRepository: quantityOfWordsRepository,
  );
  group('language', () {
    test('must return the locale code from repository', () {
      when(() => languageRepository.getLanguageSelected()).thenAnswer((_) => 'en');

      final result = controller.getLanguageSelected();

      verify(() => languageRepository.getLanguageSelected()).called(1);
      expect(result, 'en');
    });
    test('must send the locale code to repository', () {
      controller.updateLanguageSelected('en');

      verify(() => languageRepository.setLanguageSelected('en')).called(1);
    });
    test('must return the language icon url', () {
      final result = controller.getLanguageIconUrl();

      expect(result, IconUrl.language);
    });
  });
  group('dark theme', () {
    test('must return the locale code from repository', () {
      when(() => darkThemeRepository.isDarkTheme()).thenAnswer((_) => false);

      final result = controller.isDarkTheme();

      verify(() => darkThemeRepository.isDarkTheme()).called(1);
      expect(result, false);
    });
    test('must send the dark theme situation to repository', () {
      controller.updateDarkTheme(true);

      verify(() => darkThemeRepository.setDarkTheme(true)).called(1);
    });
    test('must return the dark theme icon url', () {
      when(() => darkThemeRepository.isDarkTheme()).thenAnswer((_) => true);

      final result = controller.getDarkThemeIconUrl();

      expect(result, IconUrl.darkTheme);
    });
    test('must return the light theme icon url', () {
      when(() => darkThemeRepository.isDarkTheme()).thenAnswer((_) => false);

      final result = controller.getDarkThemeIconUrl();

      expect(result, IconUrl.lightTheme);
    });
  });
  group('writing hand', () {
    test('must return the writing hand from repository', () {
      when(() => writingHandRepository.getWritingHandSelected()).thenAnswer((_) => WritingHand.left);

      final result = controller.getWritingHandSelected();

      verify(() => writingHandRepository.getWritingHandSelected()).called(1);
      expect(result, WritingHand.left);
    });
    test('must send the dark theme situation to repository', () {
      controller.updateWritingHandSelected(WritingHand.right);

      verify(() => writingHandRepository.setWritingHandSelected(WritingHand.right)).called(1);
    });
    test('must return the writing hand left icon url', () {
      when(() => writingHandRepository.getWritingHandSelected()).thenAnswer((_) => WritingHand.left);

      final result = controller.getWritingHandIconUrl();

      expect(result, IconUrl.writingHandLeft);
    });
    test('must return the writing hand right icon url', () {
      when(() => writingHandRepository.getWritingHandSelected()).thenAnswer((_) => WritingHand.right);

      final result = controller.getWritingHandIconUrl();

      expect(result, IconUrl.writingHandRight);
    });
    test('must return the writing hand data', () {
      final result = controller.getWritingHandData();

      expect(result.length, 2);
      expect(result[0].writingHand, WritingHand.left);
      expect(result[0].iconUrl, IconUrl.writingHandLeft);
      expect(result[1].writingHand, WritingHand.right);
      expect(result[1].iconUrl, IconUrl.writingHandRight);
    });
  });
  group('show hint', () {
    test('must return the show hint value from repository', () {
      when(() => showHintRepository.isShowHint()).thenAnswer((_) => false);

      final result = controller.isShowHint();

      verify(() => showHintRepository.isShowHint()).called(1);
      expect(result, false);
    });
    test('must send the show hitn value to repository', () {
      controller.updateShowHint(true);

      verify(() => showHintRepository.setShowHint(true)).called(1);
    });
    test('must return the show hint icon url', () {
      when(() => showHintRepository.isShowHint()).thenAnswer((_) => true);

      final result = controller.getShowHintIconUrl();

      expect(result, IconUrl.showHint);
    });
    test('must return the not show hint icon url', () {
      when(() => showHintRepository.isShowHint()).thenAnswer((_) => false);

      final result = controller.getShowHintIconUrl();

      expect(result, IconUrl.notShowHint);
    });
  });
  group('kana type', () {
    test('must return the kana type from repository', () {
      when(() => kanaTypeRepository.getKanaType()).thenAnswer((_) => KanaType.hiragana);

      final result = controller.getKanaTypeSelected();

      verify(() => kanaTypeRepository.getKanaType()).called(1);
      expect(result, KanaType.hiragana);
    });
    test('must send the kana type to repository', () {
      controller.updateKanaTypeSelected(KanaType.both);

      verify(() => kanaTypeRepository.setKanaType(KanaType.both)).called(1);
    });
    test('must return the kana type hiragana icon url', () {
      when(() => kanaTypeRepository.getKanaType()).thenAnswer((_) => KanaType.hiragana);

      final result = controller.getKanaTypeIconUrl();

      expect(result, IconUrl.hiragana);
    });
    test('must return the kana type katakana icon url', () {
      when(() => kanaTypeRepository.getKanaType()).thenAnswer((_) => KanaType.katakana);

      final result = controller.getKanaTypeIconUrl();

      expect(result, IconUrl.katakana);
    });
    test('must return the kana type both icon url', () {
      when(() => kanaTypeRepository.getKanaType()).thenAnswer((_) => KanaType.both);

      final result = controller.getKanaTypeIconUrl();

      expect(result, IconUrl.both);
    });
    test('must return the writing hand data', () {
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
  group('kana type', () {
    test('must return the quantity from repository', () {
      when(() => quantityOfWordsRepository.getQuantityOfWords()).thenAnswer((_) => 7);

      final result = controller.getQuantityOfWords();

      verify(() => quantityOfWordsRepository.getQuantityOfWords()).called(1);
      expect(result, 7);
    });
    test('must send the quantity to repository', () {
      controller.updateQuantityOfWords(10);

      verify(() => quantityOfWordsRepository.setQuantityOfWords(10)).called(1);
    });
    test('must return the quantity of cards icon url', () {
      final result = controller.getQuantityOfWordsIconUrl();

      expect(result, IconUrl.quantityOfWords);
    });
    test('must return the minimum quantity of cards', () {
      final result = controller.getMinimumQuantityOfWords();

      expect(result, Default.minimumTrainingCards.toDouble());
    });
    test('must return the maximum quantity of cards', () {
      final result = controller.getMaximumQuantityOfWords();

      expect(result, Default.maximumTrainingCards.toDouble());
    });
  });
  group('about', () {
    test('must return the about icon url', () {
      final result = controller.getAboutIconUrl();

      expect(result, IconUrl.about);
    });
  });
  group('privacy policy', () {
    test('must return the about icon url', () {
      final result = controller.getPrivacyPolicyIconUrl();

      expect(result, IconUrl.privacyPolicy);
    });
  });
  group('support', () {
    test('must return the about icon url', () {
      final result = controller.getSupportIconUrl();

      expect(result, IconUrl.support);
    });
  });
}

class LanguageRepositoryMock extends Mock implements ILanguageRepository {}

class WritingHandRepositoryMock extends Mock implements IWritingHandRepository {}

class DarkThemeRepositoryMock extends Mock implements IDarkThemeRepository {}

class ShowHintRepositoryMock extends Mock implements IShowHintRepository {}

class KanaTypeRepositoryMock extends Mock implements IKanaTypeRepository {}

class QuantityOfWordsRepositoryMock extends Mock implements IQuantityOfWordsRepository {}
