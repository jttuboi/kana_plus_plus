import 'package:kana_plus_plus/src/data/singletons/database.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/repositories/dark_theme.interface.repository.dart';

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
