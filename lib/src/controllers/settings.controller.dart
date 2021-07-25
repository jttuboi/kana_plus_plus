import 'package:kana_plus_plus/src/repositories/interface/settings.repository.dart';
import 'package:kana_plus_plus/src/shared/writing_hand.dart';
import 'package:kana_plus_plus/src/views/providers/writing_hand_provider.dart';

class SettingsController {
  SettingsController(this.repository);

  ISettingsRepository repository;

  String getSelectedLanguageKey() {
    return repository.getLanguage();
  }

  void updateLanguage(String value) {
    repository.saveLanguage(value);
  }

  List<WritingHandModel> getWritingHands() {
    return [
      WritingHandModel(
          key: WritingHand.left,
          url: "lib/assets/icons/black/writing_hand_left.png"),
      WritingHandModel(
          key: WritingHand.right,
          url: "lib/assets/icons/black/writing_hand_right.png"),
    ];
  }

  WritingHand getSelectedWritingHandKey() {
    return WritingHand.values[repository.getWritingHandSelectedKey()];
  }

  void updateWritingHand(WritingHand value) {
    repository.saveWritingHandSelectedKey(value.index);
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
