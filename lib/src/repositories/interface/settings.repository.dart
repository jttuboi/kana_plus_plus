import 'package:kana_plus_plus/src/models/writing_hand.model.dart';

abstract class ISettingsRepository {
  String getLanguageSelected();

  void saveLanguageSelected(String value);

  List<WritingHandModel> getWritingHandData();

  int getWritingHandSelected();

  void saveWritingHandSelected(int value);

  bool getDarkTheme();

  void saveDarkTheme(bool value);

  bool getShowHint();

  void saveShowHint(bool value);
}
