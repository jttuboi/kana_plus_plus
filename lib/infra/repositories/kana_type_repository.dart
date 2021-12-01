import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';

class KanaTypeRepository implements IKanaTypeRepository {
  KanaTypeRepository(this.database);

  IDatabase database;

  @override
  Future<KanaType> getKanaType() async {
    await database.load(BoxTag.settings);
    return database.get(DatabaseTag.kanaType, defaultValue: KanaType.both);
  }

  @override
  Future<void> updateKanaType(KanaType kanaType) async {
    await database.load(BoxTag.settings);
    await database.put(DatabaseTag.kanaType, kanaType);
  }
}
