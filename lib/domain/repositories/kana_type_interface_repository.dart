import 'package:kwriting/domain/domain.dart';

abstract class IKanaTypeRepository {
  Future<KanaType> getKanaType();

  Future<void> updateKanaType(KanaType kanaType);
}
