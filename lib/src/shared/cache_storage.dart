import 'package:kana_plus_plus/src/repositories/interface/cache_storage.provider.dart';

class CacheStorage {
  // singleton
  factory CacheStorage() => _instance;
  CacheStorage._internal();
  static final CacheStorage _instance = CacheStorage._internal();

  static late ICacheStorageProvider _provider;

  // init cache storage. this init() is recommend to start before runApp().
  static Future<void> init({required ICacheStorageProvider provider}) async {
    _provider = provider;
    await _provider.init();
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return _provider.getInt(key, defaultValue: defaultValue);
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return _provider.getBool(key, defaultValue: defaultValue);
  }

  static void setInt(String key, int value) {
    _provider.setInt(key, value);
  }

  static void setBool(String key, bool value) {
    _provider.setBool(key, value);
  }
}
