abstract class IShowHintRepository {
  bool isShowHint();

  void setShowHint(bool value);

  Future<bool> getShowHint();

  Future<void> updateShowHint(bool showHint);
}
