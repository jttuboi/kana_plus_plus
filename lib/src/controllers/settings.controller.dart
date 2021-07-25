import 'package:kana_plus_plus/src/models/writing_hand.model.dart';
import 'package:kana_plus_plus/src/repositories/interface/settings.repository.dart';
import 'package:kana_plus_plus/src/shared/writing_hand.dart';

class SettingsController {
  SettingsController(this.repository);

  ISettingsRepository repository;

  String getSelectedLanguageKey() {
    return repository.getLanguage();
  }

  void updateLanguage(String value) {
    repository.saveLanguage(value);
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

  void updateDarkTheme(bool value) {
    repository.saveDarkTheme(value);
  }

  String getDarkThemeIconUrl(bool value) {
    return value
        ? "lib/assets/icons/black/dark_theme.png"
        : "lib/assets/icons/black/light_mode.png";
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
