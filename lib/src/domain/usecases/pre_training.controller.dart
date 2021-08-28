import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type_data.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/kana_type.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/quantity_of_words.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/show_hint.interface.repository.dart';

class PreTrainingController {
  PreTrainingController({
    required this.showHintRepository,
    required this.kanaTypeRepository,
    required this.quantityOfWordsRepository,
  });

  final IShowHintRepository showHintRepository;
  final IKanaTypeRepository kanaTypeRepository;
  final IQuantityOfWordsRepository quantityOfWordsRepository;

  late bool showHint;
  late KanaType kanaType;
  late int quantityOfWords;

  bool isShowHint() {
    return showHintRepository.isShowHint();
  }

  String getShowHintIconUrl() {
    return showHint ? IconUrl.showHint : IconUrl.notShowHint;
  }

  KanaType getKanaType() {
    return kanaTypeRepository.getKanaType();
  }

  List<KanaTypeData> getKanaTypeData() {
    return [
      const KanaTypeData(type: KanaType.hiragana, iconUrl: IconUrl.hiragana),
      const KanaTypeData(type: KanaType.katakana, iconUrl: IconUrl.katakana),
      const KanaTypeData(type: KanaType.both, iconUrl: IconUrl.both),
    ];
  }

  String getKanaTypeIconUrl() {
    return getKanaTypeData().where((kanaTypeItem) => kanaTypeItem.type.equal(kanaType)).first.iconUrl;
  }

  int getQuantityOfWords() {
    return quantityOfWordsRepository.getQuantityOfWords();
  }

  double getMinimumQuantityOfWords() {
    return Default.minimumTrainingCards.toDouble();
  }

  double getMaximumQuantityOfWords() {
    return Default.maximumTrainingCards.toDouble();
  }

  String getQuantityOfWordsIconUrl() {
    return IconUrl.quantityOfWords;
  }
}
