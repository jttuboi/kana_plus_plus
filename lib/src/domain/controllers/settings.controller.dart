import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/models/description.model.dart';
import 'package:kana_plus_plus/src/domain/core/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type_data.dart';
import 'package:kana_plus_plus/src/domain/core/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand_data.dart';
import 'package:kana_plus_plus/src/domain/repositories/dark_theme.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/kana_type.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/language.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/quantity_of_words.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/show_hint.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/writing_hand.interface.repository.dart';

class SettingsController {
  SettingsController({
    required this.languageRepository,
    required this.writingHandRepository,
    required this.darkThemeRepository,
    required this.showHintRepository,
    required this.kanaTypeRepository,
    required this.quantityOfWordsRepository,
  });

  final ILanguageRepository languageRepository;
  final IWritingHandRepository writingHandRepository;
  final IDarkThemeRepository darkThemeRepository;
  final IShowHintRepository showHintRepository;
  final IKanaTypeRepository kanaTypeRepository;
  final IQuantityOfWordsRepository quantityOfWordsRepository;

  String get languageSelected => languageRepository.getLanguageSelected();

  void updateLanguageSelected(String value) {
    languageRepository.setLanguageSelected(value);
  }

  bool get darkThemeSelected => darkThemeRepository.isDarkTheme();

  void updateDarkThemeSelected(bool value) {
    darkThemeRepository.setDarkTheme(value);
  }

  String get darkThemeIconUrl => (darkThemeRepository.isDarkTheme()) ? IconUrl.darkTheme : IconUrl.lightTheme;

  WritingHand get writingHandSelected => writingHandRepository.getWritingHandSelected();

  void updateWritingHandSelected(WritingHand value) {
    writingHandRepository.setWritingHandSelected(value);
  }

  String get writingHandIconUrl => getWritingHandData.firstWhere((model) {
        return model.writingHand.equal(writingHandRepository.getWritingHandSelected());
      }).iconUrl;

  List<WritingHandData> get getWritingHandData => [
        const WritingHandData(writingHand: WritingHand.left, iconUrl: IconUrl.writingHandLeft),
        const WritingHandData(writingHand: WritingHand.right, iconUrl: IconUrl.writingHandRight),
      ];

  bool get showHintSelected => showHintRepository.isShowHint();

  void updateShowHintSelected(bool value) {
    showHintRepository.setShowHint(value);
  }

  String get showHintIconUrl => (showHintRepository.isShowHint()) ? IconUrl.showHint : IconUrl.notShowHint;

  KanaType get kanaTypeSelected => kanaTypeRepository.getKanaType();

  void updateKanaTypeSelected(KanaType value) {
    kanaTypeRepository.setKanaType(value);
  }

  String get kanaTypeIconUrl => kanaTypeData.firstWhere((model) {
        return model.type.equal(kanaTypeRepository.getKanaType());
      }).iconUrl;

  List<KanaTypeData> get kanaTypeData => [
        const KanaTypeData(type: KanaType.hiragana, iconUrl: IconUrl.hiragana),
        const KanaTypeData(type: KanaType.katakana, iconUrl: IconUrl.katakana),
        const KanaTypeData(type: KanaType.both, iconUrl: IconUrl.both),
      ];

  int get quantityOfWords => quantityOfWordsRepository.getQuantityOfWords();

  void updateQuantityOfWords(int value) {
    quantityOfWordsRepository.setQuantityOfWords(value);
  }

  List<DescriptionModel> get aboutDescriptions => [
        DescriptionModel.title('blablable'),
        DescriptionModel.content('informaçoes sobre mim'),
        DescriptionModel.content('contato'),
        DescriptionModel.content('de onde os dados vieram'),
      ];

  List<DescriptionModel> get privacyPolicyDescriptions => [
        DescriptionModel.title('citar sobre uso'),
        DescriptionModel.content(
            'blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla'),
      ];
}
