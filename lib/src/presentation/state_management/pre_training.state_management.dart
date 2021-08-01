import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/usecases/pre_training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';

class PreTrainingStateManagement extends ChangeNotifier {
  PreTrainingStateManagement(this._controller) {
    showHint = _controller.getShowHint();
    kanaType = _controller.getKanaType();
    quantityOfWords = _controller.getQuantityOfWords();
  }

  final PreTrainingController _controller;

  late bool showHint;

  String get showHintIconUrl => _controller.getShowHintIconUrl();

  void updateShowHint(bool value) {
    showHint = value;
    notifyListeners();
  }

  late KanaType kanaType;

  String get kanaTypeIconUrl => _controller.getKanaTypeIconUrl(kanaType);

  List<SelectionOptionArguments> getKanaTypeOptions(
      String Function(KanaType kanaType) kanaTypeText) {
    return _controller.getKanaTypeData().map((model) {
      return SelectionOptionArguments(
        key: model.kanaType,
        label: kanaTypeText(model.kanaType),
        iconUrl: model.iconUrl,
      );
    }).toList();
  }

  void updateKanaType(KanaType value) {
    kanaType = value;
    notifyListeners();
  }

  late int quantityOfWords;

  double get minWords => _controller.getMinimumQuantityOfWords();

  double get maxWords => _controller.getMaximumQuantityOfWords();

  String get quantityOfWordsIconUrl => _controller.getQuantityOfWordsIconUrl();

  void updateQuantity(double value) {
    quantityOfWords = value.toInt();
    notifyListeners();
  }
}
