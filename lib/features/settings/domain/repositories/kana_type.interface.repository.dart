import 'package:kwriting/core/core.dart';

abstract class IKanaTypeRepository {
  KanaType getKanaType2();

  void setKanaType(KanaType value);

  Future<KanaType> getKanaType();

  Future<void> updateKanaType(KanaType kanaType);
}
