import 'package:kana_plus_plus/src/data/singletons/cache.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_type.dart';
import 'package:kana_plus_plus/src/domain/repositories/kana_type.interface.repository.dart';

class KanaTypeRepository implements IKanaTypeRepository {
  @override
  KanaType getKanaType() {
    final int kanaIndex = Cache.getInt(SettingsPref.kanaType, defaultValue: KanaType.both.index);
    return KanaType.values[kanaIndex];
  }

  @override
  void setKanaType(KanaType value) {
    Cache.setInt(SettingsPref.kanaType, value.index);
  }
}
