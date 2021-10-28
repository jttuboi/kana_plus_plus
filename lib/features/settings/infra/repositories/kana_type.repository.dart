import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:kwriting/src/infra/singletons/database.dart';

class KanaTypeRepository implements IKanaTypeRepository {
  @override
  KanaType getKanaType() {
    final kanaIndex = Database.storage.getInt(DatabaseTag.kanaType, defaultValue: KanaType.both.index);
    return KanaType.values[kanaIndex];
  }

  @override
  void setKanaType(KanaType value) {
    Database.storage.setInt(DatabaseTag.kanaType, value.index);
  }
}
