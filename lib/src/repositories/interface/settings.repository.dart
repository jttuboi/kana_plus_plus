abstract class ISettingsRepository {
  String getLanguage();

  void saveLanguage(String value);

  bool getDarkTheme();

  void saveDarkTheme(bool value);

  bool getShowHint();

  void saveShowHint(bool value);
}
