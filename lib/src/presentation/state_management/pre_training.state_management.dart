import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_type.dart';
import 'package:kana_plus_plus/src/domain/usecases/pre_training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';

class PreTrainingStateManagement extends ChangeNotifier {
  PreTrainingStateManagement(this._controller) {
    _controller.showHint = _controller.isShowHint();
    _controller.kanaType = _controller.getKanaType();
    _controller.quantityOfWords = _controller.getQuantityOfWords();
  }

  final PreTrainingController _controller;

  bool get showHint => _controller.showHint;

  String get showHintIconUrl => _controller.getShowHintIconUrl();

  void updateShowHint(bool value) {
    _controller.showHint = value;
    notifyListeners();
  }

  KanaType get kanaType => _controller.kanaType;

  String get kanaTypeIconUrl => _controller.getKanaTypeIconUrl();

  List<SelectionOptionArguments> getKanaTypeOptions(String Function(KanaType kanaType) kanaTypeText) {
    return _controller.getKanaTypeData().map((model) {
      return SelectionOptionArguments(
        key: model.type,
        label: kanaTypeText(model.type),
        iconUrl: model.iconUrl,
      );
    }).toList();
  }

  void updateKanaType(KanaType value) {
    _controller.kanaType = value;
    notifyListeners();
  }

  int get quantityOfWords => _controller.quantityOfWords;

  double get minWords => _controller.getMinimumQuantityOfWords();

  double get maxWords => _controller.getMaximumQuantityOfWords();

  String get quantityOfWordsIconUrl => _controller.getQuantityOfWordsIconUrl();

  void updateQuantity(double value) {
    _controller.quantityOfWords = value.toInt();
    notifyListeners();
  }
}
