import 'package:kwriting/src/data/singletons/database.dart';
import 'package:kwriting/src/data/utils/consts.dart';
import 'package:kwriting/src/domain/repositories/kana_type.interface.repository.dart';
import 'package:kwriting/src/domain/utils/kana_type.dart';

class KanaTypeRepository implements IKanaTypeRepository {
  @override
  KanaType getKanaType() {
    final int kanaIndex = Database.getInt(DatabaseTag.kanaType, defaultValue: KanaType.both.index);
    return KanaType.values[kanaIndex];
  }

  @override
  void setKanaType(KanaType value) {
    Database.setInt(DatabaseTag.kanaType, value.index);
  }
}
