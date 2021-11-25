abstract class ILanguageRepository {
  Future<String> getLanguage();

  Future<void> updateLanguage(String localeCode);
}
