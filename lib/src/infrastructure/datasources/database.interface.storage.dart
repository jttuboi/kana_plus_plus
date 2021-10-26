abstract class IDatabaseStorage {
  Future<void> init();

  int getInt(String key, {int defaultValue = 0});

  bool getBool(String key, {bool defaultValue = false});

  String getString(String key, {String defaultValue = ''});

  Future<void> setInt(String key, int value);

  Future<void> setBool(String key, bool value);

  Future<void> setString(String key, String value);
}
