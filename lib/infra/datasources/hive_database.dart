import 'package:hive/hive.dart';
import 'package:kwriting/infra/infra.dart';

class HiveDatabase implements IDatabase {
  late Box _box;

  @override
  Future<void> load(String boxTag) async {
    _box = (Hive.isBoxOpen(boxTag)) ? Hive.box(boxTag) : await Hive.openBox(boxTag);
  }

  @override
  dynamic get(String databaseTag, {dynamic defaultValue}) {
    return _box.get(databaseTag, defaultValue: defaultValue);
  }

  @override
  Future<void> put(String databaseTag, dynamic value) async {
    await _box.put(databaseTag, value);
  }

  @override
  Future<void> add(dynamic value) async {
    await _box.add(value);
  }

  @override
  Iterable<dynamic> get values {
    return _box.values;
  }
}
