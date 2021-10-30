import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class PreTrainingController {
  PreTrainingController({
    required this.showHintRepository,
    required this.kanaTypeRepository,
    required this.quantityOfWordsRepository,
  }) {
    showHint = showHintRepository.isShowHint();
    kanaType = kanaTypeRepository.getKanaType2();
    quantityOfWords = quantityOfWordsRepository.getQuantityOfWords2();
  }

  final IShowHintRepository showHintRepository;
  final IKanaTypeRepository kanaTypeRepository;
  final IQuantityOfWordsRepository quantityOfWordsRepository;

  late bool showHint;
  late KanaType kanaType;
  late int quantityOfWords;

  String get showHintIconUrl => showHint ? IconUrl.showHint : IconUrl.notShowHint;

  List<KanaTypeData> get kanaTypeData => [
        const KanaTypeData(kanaType: KanaType.hiragana, iconUrl: IconUrl.hiragana),
        const KanaTypeData(kanaType: KanaType.katakana, iconUrl: IconUrl.katakana),
        const KanaTypeData(kanaType: KanaType.both, iconUrl: IconUrl.both),
      ];

  String get kanaTypeIconUrl => kanaTypeData.where((kanaTypeItem) => kanaTypeItem.kanaType.equal(kanaType)).first.iconUrl;
}
