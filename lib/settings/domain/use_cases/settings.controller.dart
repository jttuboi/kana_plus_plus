import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:kwriting/training/training.dart';

class SettingsController {
  SettingsController({
    required this.languageRepository,
    required this.writingHandRepository,
    required this.showHintRepository,
    required this.kanaTypeRepository,
    required this.quantityOfWordsRepository,
  });

  final ILanguageRepository languageRepository;
  final IWritingHandRepository writingHandRepository;
  final IShowHintRepository showHintRepository;
  final IKanaTypeRepository kanaTypeRepository;
  final IQuantityOfWordsRepository quantityOfWordsRepository;

  String get languageSelected => languageRepository.getLanguageSelected();

  void updateLanguageSelected(String value) {
    languageRepository.setLanguageSelected(value);
  }

  WritingHand get writingHandSelected => writingHandRepository.getWritingHandSelected();

  void updateWritingHandSelected(WritingHand value) {
    writingHandRepository.setWritingHandSelected(value);
  }

  String get writingHandIconUrl => getWritingHandData.firstWhere((model) {
        return model.writingHand.equal(writingHandRepository.getWritingHandSelected());
      }).iconUrl;

  List<WritingHandData> get getWritingHandData => [
        const WritingHandData(writingHand: WritingHand.left, iconUrl: IconUrl.writingHandLeft),
        const WritingHandData(writingHand: WritingHand.right, iconUrl: IconUrl.writingHandRight),
      ];

  bool get showHintSelected => showHintRepository.isShowHint();

  void updateShowHintSelected(bool value) {
    showHintRepository.setShowHint(value);
  }

  String get showHintIconUrl => (showHintRepository.isShowHint()) ? IconUrl.showHint : IconUrl.notShowHint;

  KanaType get kanaTypeSelected => kanaTypeRepository.getKanaType();

  void updateKanaTypeSelected(KanaType value) {
    kanaTypeRepository.setKanaType(value);
  }

  String get kanaTypeIconUrl => kanaTypeData.firstWhere((model) {
        return model.type.equal(kanaTypeRepository.getKanaType());
      }).iconUrl;

  List<KanaTypeData> get kanaTypeData => [
        const KanaTypeData(type: KanaType.hiragana, iconUrl: IconUrl.hiragana),
        const KanaTypeData(type: KanaType.katakana, iconUrl: IconUrl.katakana),
        const KanaTypeData(type: KanaType.both, iconUrl: IconUrl.both),
      ];

  int get quantityOfWords => quantityOfWordsRepository.getQuantityOfWords();

  void updateQuantityOfWords(int value) {
    quantityOfWordsRepository.setQuantityOfWords(value);
  }
}
