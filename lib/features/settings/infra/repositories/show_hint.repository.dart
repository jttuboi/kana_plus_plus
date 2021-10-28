import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:kwriting/src/infra/singletons/database.dart';

class ShowHintRepository implements IShowHintRepository {
  @override
  bool isShowHint() {
    return Database.storage.getBool(DatabaseTag.showHint, defaultValue: Default.showHint);
  }

  @override
  void setShowHint(bool value) {
    Database.storage.setBool(DatabaseTag.showHint, value);
  }
}
