abstract class ISettingsRepository {
  Future<bool> getShowHint();
  Future<void> saveShowHint(bool value);
}
