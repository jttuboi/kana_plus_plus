abstract class IShowHintRepository {
  Future<bool> getShowHint();

  Future<void> updateShowHint(bool showHint);
}
