import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:kwriting/training/training.dart';

class PreTrainingController {
  PreTrainingController({
    required this.showHintRepository,
    required this.kanaTypeRepository,
    required this.quantityOfWordsRepository,
  }) {
    showHint = showHintRepository.isShowHint();
    kanaType = kanaTypeRepository.getKanaType();
    quantityOfWords = quantityOfWordsRepository.getQuantityOfWords();
  }

  final IShowHintRepository showHintRepository;
  final IKanaTypeRepository kanaTypeRepository;
  final IQuantityOfWordsRepository quantityOfWordsRepository;

  late bool showHint;
  late KanaType kanaType;
  late int quantityOfWords;

  String get showHintIconUrl => showHint ? IconUrl.showHint : IconUrl.notShowHint;

  List<KanaTypeData> get kanaTypeData => [
        const KanaTypeData(type: KanaType.hiragana, iconUrl: IconUrl.hiragana),
        const KanaTypeData(type: KanaType.katakana, iconUrl: IconUrl.katakana),
        const KanaTypeData(type: KanaType.both, iconUrl: IconUrl.both),
      ];

  String get kanaTypeIconUrl => kanaTypeData.where((kanaTypeItem) => kanaTypeItem.type.equal(kanaType)).first.iconUrl;
}
