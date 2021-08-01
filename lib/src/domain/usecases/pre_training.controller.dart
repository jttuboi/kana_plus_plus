import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type_data.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/kana_type.interface.dart';
import 'package:kana_plus_plus/src/domain/repositories/quantity_of_words.interface.dart';
import 'package:kana_plus_plus/src/domain/repositories/show_hint.interface.dart';

class PreTrainingController {
  PreTrainingController({
    required this.showHintRepository,
    required this.kanaTypeRepository,
    required this.quantityOfWordsRepository,
  });

  final IShowHintRepository showHintRepository;
  final IKanaTypeRepository kanaTypeRepository;
  final IQuantityOfWordsRepository quantityOfWordsRepository;

  bool getShowHint() {
    // testa se retorna true ou vfalser e se
    return showHintRepository.isShowHint();
  }

  String getShowHintIconUrl() {
    //testa se é dark omode ou light mode dependendo do value
    return (showHintRepository.isShowHint())
        ? IconUrl.showHint
        : IconUrl.notShowHint;
  }

  KanaType getKanaType() {
    // testa se retorna algum dos tipos de kana type
    return kanaTypeRepository.getKanaType();
  }

  List<KanaTypeData> getKanaTypeData() {
    // deve testar x e y dados
    /// talvez nao deva passar pra frente e sim deixar aqui
    return kanaTypeRepository.getKanaTypeData();
  }

  String getKanaTypeIconUrl(KanaType kanaType) {
    return kanaTypeRepository
        .getKanaTypeData()
        .where((kanaTypeItem) => kanaTypeItem.kanaType.equal(kanaType))
        .first
        .iconUrl;
  }

  int getQuantityOfWords() {
    // se nao esta entre 5 e 20 ele reseta
    return quantityOfWordsRepository.getQuantityOfWords();
  }

  double getMinimumQuantityOfWords() {
    return quantityOfWordsRepository.getMinWords();
  }

  double getMaximumQuantityOfWords() {
    return quantityOfWordsRepository.getMaxWords();
  }

  String getQuantityOfWordsIconUrl() {
    // testa se retorna icone certo
    return IconUrl.quantityOfWords;
  }
}
