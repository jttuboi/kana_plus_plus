abstract class ISettingsRepository {

  bool getDarkMode();

  void saveDarkMode(bool value);

  bool getShowHint();

  void saveShowHint(bool value);
}
