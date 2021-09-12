import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/controllers/pre_training.controller.dart';
import 'package:kana_plus_plus/src/domain/core/kana_type.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';

class PreTrainingProvider extends ChangeNotifier {
  PreTrainingProvider(this._controller);

  final PreTrainingController _controller;

  void updateShowHint(bool value) {
    _controller.showHint = value;
    notifyListeners();
  }

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

  void updateQuantity(double value) {
    _controller.quantityOfWords = value.toInt();
    notifyListeners();
  }
}
