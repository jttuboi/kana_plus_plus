import 'package:kwriting/settings/domain/repositories/language.interface.repository.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';
import 'package:kwriting/src/infrastructure/utils/consts.dart';

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
