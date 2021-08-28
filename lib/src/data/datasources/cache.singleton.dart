import 'package:kana_plus_plus/src/data/datasources/cache.interface.storage.dart';

class Cache {
  // singleton
  factory Cache() => _instance;
  Cache._internal();
  static final Cache _instance = Cache._internal();

  static late ICacheStorage _storage;

  // init cache storage. this init() is recommend to start before runApp().
  static Future<void> init({required ICacheStorage storage}) async {
    _storage = storage;
    await _storage.init();
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _storage.getInt(key, defaultValue: defaultValue);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _storage.getBool(key, defaultValue: defaultValue);
  }

  static String getString(String key, {String defaultValue = ""}) {
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
