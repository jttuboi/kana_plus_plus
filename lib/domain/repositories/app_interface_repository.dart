abstract class IAppRepository {
  Future<bool> isFirstTime();

  Future<void> setFirstTime(bool isFirstTime);
}
