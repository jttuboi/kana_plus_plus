import 'package:kwriting/src/data/singletons/database.dart';
import 'package:kwriting/src/data/utils/consts.dart';
import 'package:kwriting/src/domain/repositories/language.interface.repository.dart';
import 'package:kwriting/src/domain/utils/consts.dart';

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
