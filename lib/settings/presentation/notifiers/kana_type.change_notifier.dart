import 'package:flutter/widgets.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';

class KanaTypeChangeNotifier extends ChangeNotifier {
  KanaTypeChangeNotifier(this._controller);

  final SettingsController _controller;

  KanaType get kanaType => _controller.kanaTypeSelected;

  String get iconUrl => _controller.kanaTypeIconUrl;

  List<SelectionOptionItem> options(String Function(KanaType kanaType) kanaTypeText) {
    return _controller.kanaTypeData.map((model) {
      return SelectionOptionItem(
        key: model.type,
        label: kanaTypeText(model.type),
        iconUrl: model.iconUrl,
      );
    }).toList();
  }

  void updateKanaType(KanaType pSelectedKey) {
    _controller.updateKanaTypeSelected(pSelectedKey);
    notifyListeners();
  }
}
