import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:kana_plus_plus/src/data/models/description.model.dart';
import 'package:kana_plus_plus/src/data/models/kana_type.model.dart';
import 'package:kana_plus_plus/src/data/models/writing_hand.model.dart';
import 'package:kana_plus_plus/src/domain/repositories/settings.interface.dart';
import 'package:kana_plus_plus/src/data/datasources/cache.singleton.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';

class SettingsRepository implements ISettingsRepository {
  @override
  String getLanguageSelected() {
    return Cache.getString("language", defaultValue: "en");
  }

  @override
  String getLanguageIconUrl() {
    return "lib/assets/icons/black/language.png";
  }

  @override
  void saveLanguageSelected(String value) {
    Cache.setString("language", value);
  }

  @override
  String getLanguageText(String key) {
    return LocaleNamesLocalizationsDelegate.nativeLocaleNames[key] ?? "English";
  }

  // TODO colocar numa database
  @override
  List<WritingHandModel> getWritingHandData() {
    return [
      // OBS: TEM Q CONVERTER INT EM WRITING HAND, SE NAO
      // DER PRA FAZER AUTOMATICAMENTE,, ENTAO PRECISA PASSAR ESSA FUNCAO DE
      // CONVERTER PARA CONTROLLER
      WritingHandModel(
          key: WritingHand.left,
          url: "lib/assets/icons/black/writing_hand_left.png"),
      WritingHandModel(
          key: WritingHand.right,
          url: "lib/assets/icons/black/writing_hand_right.png"),
    ];
  }

  @override
  WritingHand getWritingHandSelected() {
    final int writingHandIndex =
        Cache.getInt("writing_hand", defaultValue: WritingHand.right.index);
    return WritingHand.values[writingHandIndex];
  }

  @override
  void saveWritingHandSelected(WritingHand value) {
    Cache.setInt("writing_hand", value.index);
  }

  @override
  bool isDarkTheme() {
    return Cache.getBool("dark_theme");
  }

  @override
  String getDarkThemeIconUrl(bool value) {
    return value
        ? "lib/assets/icons/black/dark_theme.png"
        : "lib/assets/icons/black/light_mode.png";
  }

  @override
  void saveDarkTheme(bool value) {
    Cache.setBool("dark_theme", value);
  }

  @override
  bool isShowHint() {
    return Cache.getBool("show_hint", defaultValue: true);
  }

  @override
  String getShowHintIconUrl(bool value) {
    return value
        ? "lib/assets/icons/black/show_hint.png"
        : "lib/assets/icons/black/not_show_hint.png";
  }

  @override
  void saveShowHint(bool value) {
    Cache.setBool("show_hint", value);
  }

  // TODO colocar numa database
  @override
  List<KanaTypeModel> getKanaTypeData() {
    return [
      // OBS: TEM Q CONVERTER INT EM WRITING HAND, SE NAO
      // DER PRA FAZER AUTOMATICAMENTE,, ENTAO PRECISA PASSAR ESSA FUNCAO DE
      // CONVERTER PARA CONTROLLER
      KanaTypeModel(
          key: KanaType.onlyHiragana,
          url: "lib/assets/icons/black/hiragana.png"),
      KanaTypeModel(
          key: KanaType.onlyKatakana,
          url: "lib/assets/icons/black/katakana.png"),
      KanaTypeModel(
          key: KanaType.both,
          url: "lib/assets/icons/black/hiragana_katakana.png"),
    ];
  }

  @override
  KanaType getKanaTypeSelected() {
    final int kanaIndex =
        Cache.getInt("kana_type", defaultValue: KanaType.both.index);
    return KanaType.values[kanaIndex];
  }

  @override
  void saveKanaTypeSelected(KanaType value) {
    Cache.setInt("kana_type", value.index);
  }

  @override
  int getQuantityOfWords() {
    return Cache.getInt("quantity_of_words", defaultValue: 5);
  }

  @override
  String getQuantityOfWordsIconUrl() {
    return "lib/assets/icons/black/quantity_of_words.png";
  }

  @override
  void saveQuantityOfWords(int value) {
    Cache.setInt("quantity_of_words", value);
  }

  @override
  String getAboutIconUrl() {
    return "lib/assets/icons/black/about.png";
  }

  @override
  List<DescriptionModel> getAboutDescriptions() {
    return [
      DescriptionModel.title("blablable"),
      DescriptionModel.content("informaçoes sobre mim"),
      DescriptionModel.content("contato"),
      DescriptionModel.content("de onde os dados vieram"),
    ];
  }

  @override
  String getPrivacyPolicyIconUrl() {
    return "lib/assets/icons/black/privacy_policy.png";
  }

  @override
  List<DescriptionModel> getPrivacyPolicyDescriptions() {
    return [
      DescriptionModel.title("citar sobre uso"),
      DescriptionModel.content(
          "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla"),
    ];
  }

  @override
  String getSupportIconUrl() {
    return "lib/assets/icons/black/support.png";
  }
}
