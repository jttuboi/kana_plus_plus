import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';

class DarkThemeRepository implements IDarkThemeRepository {
  @override
  bool isDarkTheme() {
    return Database.getBool(DatabaseTag.darkTheme);
  }

  @override
  void setDarkTheme(bool value) {
    Database.setBool(DatabaseTag.darkTheme, value);
  }
}
