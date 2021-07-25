import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:kana_plus_plus/src/data/models/kana_type.model.dart';
import 'package:kana_plus_plus/src/data/models/writing_hand.model.dart';
import 'package:kana_plus_plus/src/domain/repositories/settings.interface.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';

class SettingsController {
  SettingsController(this.repository);

  ISettingsRepository repository;

  String getLanguageSelected() {
    return repository.getLanguageSelected();
  }

  String getLanguageIconUrl() {
    return "lib/assets/icons/black/language.png";
  }

  String getLanguageText(String key) {
    return LocaleNamesLocalizationsDelegate.nativeLocaleNames[key] ?? "English";
  }

  void updateLanguageSelected(String value) {
    repository.saveLanguageSelected(value);
  }

  List<WritingHandModel> getWritingHandData() {
    return repository.getWritingHandData();
  }

  WritingHand getWritingHandSelected() {
    return WritingHand.values[repository.getWritingHandSelected()];
  }

  void updateWritingHandSelected(WritingHand value) {
    repository.saveWritingHandSelected(value.index);
  }

  bool isDarkTheme() {
    return repository.getDarkTheme();
  }

  String getDarkThemeIconUrl(bool value) {
    return value
        ? "lib/assets/icons/black/dark_theme.png"
        : "lib/assets/icons/black/light_mode.png";
  }

  void updateDarkTheme(bool value) {
    repository.saveDarkTheme(value);
  }

  bool isShowHint() {
    return repository.getShowHint();
  }

  String getShowHintIconUrl(bool value) {
    return value
        ? "lib/assets/icons/black/show_hint.png"
        : "lib/assets/icons/black/not_show_hint.png";
  }

  void updateShowHint(bool value) {
    repository.saveShowHint(value);
  }

  List<KanaTypeModel> getKanaTypeData() {
    return repository.getKanaTypeData();
  }

  KanaType getKanaTypeSelected() {
    return KanaType.values[repository.getKanaTypeSelected()];
  }

  void updateKanaTypeSelected(KanaType value) {
    repository.saveKanaTypeSelected(value.index);
  }

  int getQuantityOfWords() {
    return repository.getQuantityOfWords();
  }

  void updateQuantityOfWords(int value) {
    repository.saveQuantityOfWords(value);
  }
}
