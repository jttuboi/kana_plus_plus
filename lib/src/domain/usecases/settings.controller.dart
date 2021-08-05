import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/models/description.model.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type_data.entity.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand_data.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/dark_theme.interface.dart';
import 'package:kana_plus_plus/src/domain/repositories/kana_type.interface.dart';
import 'package:kana_plus_plus/src/domain/repositories/language.interface.dart';
import 'package:kana_plus_plus/src/domain/repositories/quantity_of_words.interface.dart';
import 'package:kana_plus_plus/src/domain/repositories/show_hint.interface.dart';
import 'package:kana_plus_plus/src/domain/repositories/writing_hand.interface.dart';

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

  String getLanguageSelected() {
    return languageRepository.getLanguageSelected();
  }

  void updateLanguageSelected(String value) {
    languageRepository.setLanguageSelected(value);
  }

  String getLanguageIconUrl() {
    return IconUrl.language;
  }

  bool isDarkTheme() {
    return darkThemeRepository.isDarkTheme();
  }

  void updateDarkTheme(bool value) {
    darkThemeRepository.setDarkTheme(value);
  }

  String getDarkThemeIconUrl() {
    return (darkThemeRepository.isDarkTheme())
        ? IconUrl.darkTheme
        : IconUrl.lightTheme;
  }

  WritingHand getWritingHandSelected() {
    return writingHandRepository.getWritingHandSelected();
  }

  void updateWritingHandSelected(WritingHand value) {
    writingHandRepository.setWritingHandSelected(value);
  }

  String getWritingHandIconUrl() {
    return getWritingHandData().firstWhere((model) {
      return model.writingHand
          .equal(writingHandRepository.getWritingHandSelected());
    }).iconUrl;
  }

  List<WritingHandData> getWritingHandData() {
    return [
      const WritingHandData(
        writingHand: WritingHand.left,
        iconUrl: IconUrl.writingHandLeft,
      ),
      const WritingHandData(
        writingHand: WritingHand.right,
        iconUrl: IconUrl.writingHandRight,
      ),
    ];
  }

  bool isShowHint() {
    return showHintRepository.isShowHint();
  }

  void updateShowHint(bool value) {
    showHintRepository.setShowHint(value);
  }

  String getShowHintIconUrl() {
    return (showHintRepository.isShowHint())
        ? IconUrl.showHint
        : IconUrl.notShowHint;
  }

  KanaType getKanaTypeSelected() {
    return kanaTypeRepository.getKanaType();
  }

  void updateKanaTypeSelected(KanaType value) {
    kanaTypeRepository.setKanaType(value);
  }

  String getKanaTypeIconUrl() {
    return getKanaTypeData().firstWhere((model) {
      return model.type.equal(kanaTypeRepository.getKanaType());
    }).iconUrl;
  }

  List<KanaTypeData> getKanaTypeData() {
    return [
      const KanaTypeData(type: KanaType.hiragana, iconUrl: IconUrl.hiragana),
      const KanaTypeData(type: KanaType.katakana, iconUrl: IconUrl.katakana),
      const KanaTypeData(type: KanaType.both, iconUrl: IconUrl.both),
    ];
  }

  int getQuantityOfWords() {
    return quantityOfWordsRepository.getQuantityOfWords();
  }

  void updateQuantityOfWords(int value) {
    quantityOfWordsRepository.setQuantityOfWords(value);
  }

  String getQuantityOfWordsIconUrl() {
    return IconUrl.quantityOfWords;
  }

  double getMinimumQuantityOfWords() {
    return Default.minimumTrainingCards.toDouble();
  }

  double getMaximumQuantityOfWords() {
    return Default.maximumTrainingCards.toDouble();
  }

  String getAboutIconUrl() {
    return IconUrl.about;
  }

  List<DescriptionModel> getAboutDescriptions() {
    return [
      DescriptionModel.title("blablable"),
      DescriptionModel.content("informaçoes sobre mim"),
      DescriptionModel.content("contato"),
      DescriptionModel.content("de onde os dados vieram"),
    ];
  }

  String getPrivacyPolicyIconUrl() {
    return IconUrl.privacyPolicy;
  }

  List<DescriptionModel> getPrivacyPolicyDescriptions() {
    return [
      DescriptionModel.title("citar sobre uso"),
      DescriptionModel.content(
          "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla"),
    ];
  }

  String getSupportIconUrl() {
    return IconUrl.support;
  }
}
