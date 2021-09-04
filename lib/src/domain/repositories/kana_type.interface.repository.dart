import 'package:kana_plus_plus/src/domain/core/kana_type.dart';

abstract class IKanaTypeRepository {
  KanaType getKanaType();

  void setKanaType(KanaType value);
}
