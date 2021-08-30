import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_type.dart';

class KanaTypeProvider extends ChangeNotifier {
  KanaTypeProvider(this._controller);

  final SettingsController _controller;

  KanaType get kanaType => _controller.getKanaTypeSelected();

  String get iconUrl => _controller.getKanaTypeIconUrl();

  List<SelectionOptionArguments> getOptions(String Function(KanaType kanaType) kanaTypeText) {
    return _controller.getKanaTypeData().map((model) {
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
