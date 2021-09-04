import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/controllers/settings.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';
import 'package:kana_plus_plus/src/domain/core/kana_type.dart';

class KanaTypeProvider extends ChangeNotifier {
  KanaTypeProvider(this._controller);

  final SettingsController _controller;

  KanaType get kanaType => _controller.kanaTypeSelected;

  String get iconUrl => _controller.kanaTypeIconUrl;

  List<SelectionOptionArguments> options(String Function(KanaType kanaType) kanaTypeText) {
    return _controller.kanaTypeData.map((model) {
      return SelectionOptionArguments(
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
