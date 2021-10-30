import 'package:kwriting/core/core.dart';

abstract class IKanaTypeRepository {
  Future<KanaType> getKanaType();

  Future<void> updateKanaType(KanaType kanaType);
}
