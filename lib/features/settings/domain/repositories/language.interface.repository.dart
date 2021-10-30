abstract class ILanguageRepository {
  String getLanguageSelected();

  void setLanguageSelected(String value);

  Future<String> getLanguage();

  Future<void> updateLanguage(String localeCode);
}
