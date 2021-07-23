import 'package:kana_plus_plus/src/repositories/interface/settings.repository.dart';

class SettingsController {
  SettingsController(this.repository);

  ISettingsRepository repository;

  Future<bool> getShowHint() async {
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
