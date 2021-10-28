import 'package:kwriting/src/infra/datasources/database.interface.storage.dart';

class Database {
  // singleton
  factory Database() => _instance;
  Database._internal();
  static final Database _instance = Database._internal();

  static late IDatabaseStorage storage;

  // init database storage. this init() is recommend to start before runApp().
  static Future<void> init(IDatabaseStorage pStorage) async {
    storage = pStorage;
    await storage.init();
  }
}
