import 'package:kwriting/src/domain/entities/kana_type_data.dart';
import 'package:kwriting/src/domain/repositories/kana_type.interface.repository.dart';
import 'package:kwriting/src/domain/repositories/quantity_of_words.interface.repository.dart';
import 'package:kwriting/src/domain/repositories/show_hint.interface.repository.dart';
import 'package:kwriting/src/domain/utils/kana_type.dart';
import 'package:kwriting/src/infrastructure/datasources/icon_url.storage.dart';

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
