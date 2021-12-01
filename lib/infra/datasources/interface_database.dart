abstract class IDatabase {
  Future<void> load(String boxTag);

  dynamic get(String databaseTag, {dynamic defaultValue});

  Future<void> put(String databaseTag, dynamic value);

  Future<void> add(dynamic value);

  Iterable<dynamic> get values;
}
