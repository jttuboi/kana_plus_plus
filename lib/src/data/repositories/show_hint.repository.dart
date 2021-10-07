import 'package:kwriting/src/data/singletons/database.dart';
import 'package:kwriting/src/data/utils/consts.dart';
import 'package:kwriting/src/domain/repositories/show_hint.interface.repository.dart';
import 'package:kwriting/src/domain/utils/consts.dart';

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
