import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';

class ShowHintRepository implements IShowHintRepository {
  ShowHintRepository(this.database);

  IDatabase database;

  @override
  Future<bool> getShowHint() async {
    await database.load(BoxTag.settings);
    return database.get(DatabaseTag.showHint, defaultValue: Default.showHint);
  }

  @override
  Future<void> updateShowHint(bool showHint) async {
    await database.load(BoxTag.settings);
    await database.put(DatabaseTag.showHint, showHint);
  }
}
