import 'package:flutter/widgets.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:kwriting/features/training/training.dart';

class PreTrainingChangeNotifier extends ChangeNotifier {
  PreTrainingChangeNotifier(this._controller);

  final PreTrainingController _controller;

  void updateShowHint(bool value) {
    _controller.showHint = value;
    notifyListeners();
  }

  List<SelectionOptionItem> getKanaTypeOptions(String Function(KanaType kanaType) kanaTypeText) {
    return _controller.kanaTypeData.map((model) {
      return SelectionOptionItem(
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
