import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:kwriting/src/infra/singletons/database.dart';

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
