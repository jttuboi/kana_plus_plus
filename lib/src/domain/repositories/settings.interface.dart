import 'package:kana_plus_plus/src/data/models/description.model.dart';
import 'package:kana_plus_plus/src/data/models/kana_type.model.dart';
import 'package:kana_plus_plus/src/data/models/writing_hand.model.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';

abstract class ISettingsRepository {
  String getLanguageSelected();

  String getLanguageIconUrl();

  void saveLanguageSelected(String value);

  String getLanguageText(String key);

  List<WritingHandModel> getWritingHandData();

  WritingHand getWritingHandSelected();

  void saveWritingHandSelected(WritingHand value);

  bool isDarkTheme();

  String getDarkThemeIconUrl(bool value);

  void saveDarkTheme(bool value);

  bool isShowHint();

  String getShowHintIconUrl(bool value);

  void saveShowHint(bool value);

  List<KanaTypeModel> getKanaTypeData();

  KanaType getKanaTypeSelected();

  void saveKanaTypeSelected(KanaType value);

  int getQuantityOfWords();

  String getQuantityOfWordsIconUrl();

  void saveQuantityOfWords(int value);

  String getAboutIconUrl();

  List<DescriptionModel> getAboutDescriptions();

  String getPrivacyPolicyIconUrl();

  List<DescriptionModel> getPrivacyPolicyDescriptions();

  String getSupportIconUrl();
}
