import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:kana_plus_plus/src/models/writing_hand.model.dart';
import 'package:kana_plus_plus/src/repositories/interface/settings.repository.dart';
import 'package:kana_plus_plus/src/shared/writing_hand.dart';

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

  void updateShowHint(bool value) {
    repository.saveShowHint(value);
  }

  String getShowHintIconUrl(bool value) {
    return value
        ? "lib/assets/icons/black/show_hint.png"
        : "lib/assets/icons/black/not_show_hint.png";
  }
}
