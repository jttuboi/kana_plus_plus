import 'package:kana_plus_plus/src/repositories/interface/settings.repository.dart';

class SettingsController {
  SettingsController(this.repository);

  ISettingsRepository repository;

  bool getDarkMode() {
    return repository.getDarkMode();
  }

  void updateDarkMode(bool value) {
    repository.saveDarkMode(value);
  }

  String getDarkModeIconUrl(bool value) {
    return value
        ? "lib/assets/icons/black/light_mode.png"
        : "lib/assets/icons/black/dark_mode.png";
  }

  bool getShowHint() {
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
