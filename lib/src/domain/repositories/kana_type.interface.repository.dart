import 'package:kwriting/src/domain/utils/kana_type.dart';

abstract class IKanaTypeRepository {
  KanaType getKanaType();

  void setKanaType(KanaType value);
}
