import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';

class LanguageRepository implements ILanguageRepository {
  @override
  String getLanguageSelected() {
    return Database.getString(DatabaseTag.language, defaultValue: Default.locale);
  }

  @override
  void setLanguageSelected(String value) {
    Database.setString(DatabaseTag.language, value);
  }
}
