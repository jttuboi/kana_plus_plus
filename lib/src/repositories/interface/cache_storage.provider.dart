abstract class ICacheStorageProvider {
  Future<void> init();

  int getInt(String key, {int defaultValue = 0});

  bool getBool(String key, {bool defaultValue = false});

  Future<void> setInt(String key, int value);

  Future<void> setBool(String key, bool value);
}
