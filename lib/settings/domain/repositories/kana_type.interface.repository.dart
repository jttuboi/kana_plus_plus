import 'package:kwriting/core/core.dart';

abstract class IKanaTypeRepository {
  KanaType getKanaType();

  void setKanaType(KanaType value);
}
