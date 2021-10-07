import 'package:kwriting/src/data/datasources/database.interface.storage.dart';

class Database {
  // singleton
  factory Database() => _instance;
  Database._internal();
  static final Database _instance = Database._internal();

  static late IDatabaseStorage _storage;

  // init database storage. this init() is recommend to start before runApp().
  static Future<void> init({required IDatabaseStorage storage}) async {
    _storage = storage;
    await _storage.init();
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _storage.getInt(key, defaultValue: defaultValue);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _storage.getBool(key, defaultValue: defaultValue);
  }

  static String getString(String key, {String defaultValue = ''}) {
    return _storage.getString(key, defaultValue: defaultValue);
  }

  static void setInt(String key, int value) {
    _storage.setInt(key, value);
  }

  static void setBool(String key, bool value) {
    _storage.setBool(key, value);
  }

  static void setString(String key, String value) {
    _storage.setString(key, value);
  }
}
