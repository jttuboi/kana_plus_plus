import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type_data.entity.dart';

abstract class IKanaTypeRepository {
  KanaType getKanaType();

  void setKanaType(KanaType value);

  List<KanaTypeData> getKanaTypeData();
}
