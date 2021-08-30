import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_type.dart';
import 'package:kana_plus_plus/src/domain/usecases/pre_training.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';

class PreTrainingStateManagement extends ChangeNotifier {
  PreTrainingStateManagement(this._controller);

  final PreTrainingController _controller;

  bool get showHint => _controller.showHint;

  String get showHintIconUrl => _controller.showHintIconUrl;

  void updateShowHint(bool value) {
    _controller.showHint = value;
    notifyListeners();
  }

  KanaType get kanaType => _controller.kanaType;

  String get kanaTypeIconUrl => _controller.kanaTypeIconUrl;

  List<SelectionOptionArguments> getKanaTypeOptions(String Function(KanaType kanaType) kanaTypeText) {
    return _controller.kanaTypeData.map((model) {
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

  void updateQuantity(double value) {
    _controller.quantityOfWords = value.toInt();
    notifyListeners();
  }
}
