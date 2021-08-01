import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/models/description.model.dart';
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
    //testa se ... qual language? se é algum q precisada retornar?
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

  String getDarkThemeIconUrl() {
    return (darkThemeRepository.isDarkTheme())
        ? IconUrl.darkMode
        : IconUrl.lightMode;
  }

  void updateDarkTheme(bool value) {
    darkThemeRepository.setDarkTheme(value);
  }

  WritingHand getWritingHandSelected() {
    return writingHandRepository.getWritingHandSelected();
  }

  void updateWritingHandSelected(WritingHand value) {
    writingHandRepository.setWritingHandSelected(value);
  }

  List<WritingHandData> getWritingHandData() {
    return writingHandRepository.getWritingHandData();
  }

  String getWritingHandIconUrl() {
    return writingHandRepository.getWritingHandData().firstWhere((model) {
      return model.writingHand
          .equal(writingHandRepository.getWritingHandSelected());
    }).iconUrl;
  }

  bool isShowHint() {
    // testa se retorna true ou vfalser e se
    return showHintRepository.isShowHint();
  }

  String getShowHintIconUrl() {
    //testa se é dark omode ou light mode dependendo do value
    return (showHintRepository.isShowHint())
        ? IconUrl.showHint
        : IconUrl.notShowHint;
  }

  void updateShowHint(bool value) {
    showHintRepository.setShowHint(value);
  }

  KanaType getKanaTypeSelected() {
    return kanaTypeRepository.getKanaType();
  }

  String getKanaTypeIconUrl() {
    return kanaTypeRepository.getKanaTypeData().firstWhere((model) {
      return model.kanaType.equal(kanaTypeRepository.getKanaType());
    }).iconUrl;
  }

  void updateKanaTypeSelected(KanaType value) {
    kanaTypeRepository.setKanaType(value);
  }

  List<KanaTypeData> getKanaTypeData() {
    return kanaTypeRepository.getKanaTypeData();
  }

  int getQuantityOfWords() {
    return quantityOfWordsRepository.getQuantityOfWords();
  }

  double getMinimumQuantityOfWords() {
    return quantityOfWordsRepository.getMinWords();
  }

  double getMaximumQuantityOfWords() {
    return quantityOfWordsRepository.getMaxWords();
  }

  String getQuantityOfWordsIconUrl() {
    return IconUrl.quantityOfWords;
  }

  void updateQuantityOfWords(int value) {
    quantityOfWordsRepository.setQuantityOfWords(value);
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
