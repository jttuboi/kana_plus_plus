abstract class ILocalStorage {
  Future<bool> getBool(String key);
  Future<void> setBool(String key, bool value);
}
