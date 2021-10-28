import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';

class ShowHintRepository implements IShowHintRepository {
  @override
  bool isShowHint() {
    return Database.getBool(DatabaseTag.showHint, defaultValue: Default.showHint);
  }

  @override
  void setShowHint(bool value) {
    Database.setBool(DatabaseTag.showHint, value);
  }
}
