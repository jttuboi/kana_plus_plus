import 'package:kwriting/src/domain/repositories/dark_theme.interface.repository.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';
import 'package:kwriting/src/infrastructure/utils/consts.dart';

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
