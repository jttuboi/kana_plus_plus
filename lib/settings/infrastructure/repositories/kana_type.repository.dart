import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';

class KanaTypeRepository implements IKanaTypeRepository {
  @override
  KanaType getKanaType() {
    final kanaIndex = Database.getInt(DatabaseTag.kanaType, defaultValue: KanaType.both.index);
    return KanaType.values[kanaIndex];
  }

  @override
  void setKanaType(KanaType value) {
    Database.setInt(DatabaseTag.kanaType, value.index);
  }
}
