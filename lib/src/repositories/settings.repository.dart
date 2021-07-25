import 'package:kana_plus_plus/src/models/writing_hand.model.dart';
import 'package:kana_plus_plus/src/repositories/interface/settings.repository.dart';
import 'package:kana_plus_plus/src/shared/cache_storage.dart';
import 'package:kana_plus_plus/src/shared/writing_hand.dart';

class SettingsRepository implements ISettingsRepository {
  @override
  String getLanguage() {
    return CacheStorage.getString("language", defaultValue: "en");
  }

  @override
  void saveLanguage(String value) {
    CacheStorage.setString("language", value);
  }

  // TODO colocar numa database
  @override
  List<WritingHandModel> getWritingHandData() {
    return [
      // OBS: TEM Q CONVERTER INT EM WRITING HAND, SE NAO
      // DER PRA FAZER AUTOMATICAMENTE,, ENTAO PRECISA PASSAR ESSA FUNCAO DE
      // CONVERTER PARA CONTROLLER
      WritingHandModel(
          key: WritingHand.left,
          url: "lib/assets/icons/black/writing_hand_left.png"),
      WritingHandModel(
          key: WritingHand.right,
          url: "lib/assets/icons/black/writing_hand_right.png"),
    ];
  }

  @override
  int getWritingHandSelected() {
    return CacheStorage.getInt("writing_hand",
        defaultValue: WritingHand.right.index);
  }

  @override
  void saveWritingHandSelected(int value) {
    CacheStorage.setInt("writing_hand", value);
  }

  @override
  bool getDarkTheme() {
    return CacheStorage.getBool("dark_theme");
  }

  @override
  void saveDarkTheme(bool value) {
    CacheStorage.setBool("dark_theme", value);
  }

  @override
  bool getShowHint() {
    return CacheStorage.getBool("show_hint", defaultValue: true);
  }

  @override
  void saveShowHint(bool value) {
    CacheStorage.setBool("show_hint", value);
  }
}
