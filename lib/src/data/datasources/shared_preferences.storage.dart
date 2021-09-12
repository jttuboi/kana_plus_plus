import 'package:kana_plus_plus/src/data/datasources/database.interface.storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage implements IDatabaseStorage {
  late SharedPreferences _preferences;

  @override
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  @override
  bool getBool(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  @override
  String getString(String key, {String defaultValue = ''}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  @override
  Future<void> setInt(String key, int value) async {
    _preferences.setInt(key, value);
  }

  @override
  Future<void> setBool(String key, bool value) async {
    _preferences.setBool(key, value);
  }

  @override
  Future<void> setString(String key, String value) async {
    _preferences.setString(key, value);
  }
}
