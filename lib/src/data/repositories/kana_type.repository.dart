import 'package:kana_plus_plus/src/data/datasources/cache.singleton.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/models/kana_type_data.model.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type_data.entity.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/repositories/kana_type.interface.dart';

class KanaTypeRepository implements IKanaTypeRepository {
  @override
  KanaType getKanaType() {
    final int kanaIndex =
        Cache.getInt(SettingsPref.kanaType, defaultValue: KanaType.both.index);
    return KanaType.values[kanaIndex];
  }

  @override
  void setKanaType(KanaType value) {
    Cache.setInt(SettingsPref.kanaType, value.index);
  }

  @override
  List<KanaTypeData> getKanaTypeData() {
    return [
      // OBS: TEM Q CONVERTER INT EM WRITING HAND, SE NAO
      // DER PRA FAZER AUTOMATICAMENTE,, ENTAO PRECISA PASSAR ESSA FUNCAO DE
      // CONVERTER PARA CONTROLLER
      const KanaTypeDataModel(
          type: KanaType.hiragana, iconUrl: IconUrl.hiragana),
      const KanaTypeDataModel(
          type: KanaType.katakana, iconUrl: IconUrl.katakana),
      const KanaTypeDataModel(type: KanaType.both, iconUrl: IconUrl.both),
    ];
  }
}
