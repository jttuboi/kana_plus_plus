import 'package:kana_plus_plus/src/data/datasources/database.interface.storage.dart';

class Database {
  // singleton
  factory Database() => _instance;
  Database._internal();
  static final Database _instance = Database._internal();

  static late IDatabaseStorage _storage;

  static Future<void> init({required IDatabaseStorage storage}) async {
    _storage = storage;
    await _storage.init();
  }
}
