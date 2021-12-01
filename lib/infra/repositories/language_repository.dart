import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';

class LanguageRepository implements ILanguageRepository {
  LanguageRepository(this.database);

  IDatabase database;

  @override
  Future<String> getLanguage() async {
    await database.load(BoxTag.settings);
    return database.get(DatabaseTag.language, defaultValue: Default.languageCode);
  }

  @override
  Future<void> updateLanguage(String localeCode) async {
    await database.load(BoxTag.settings);
    await database.put(DatabaseTag.language, localeCode);
  }
}
