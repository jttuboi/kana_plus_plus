import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';
import 'package:kana_plus_plus/src/models/kana_type.model.dart';
import 'package:kana_plus_plus/src/shared/kana_type.dart';
import 'package:kana_plus_plus/src/views/android/pages/settings.page.dart';

class KanaTypeProvider extends ChangeNotifier {
  KanaTypeProvider(this._controller) {
    _data = _controller.getKanaTypeData();
    selectedKey = _controller.getKanaTypeSelected();
    notifyListeners();
  }

  final SettingsController _controller;
  late final List<KanaTypeModel> _data;

  late KanaType selectedKey;

  String get iconUrl {
    return _data.firstWhere((model) {
      return model.key.equal(selectedKey);
    }).url;
  }

  String text(BuildContext context) {
    return _getText(context, selectedKey);
  }

  List<SelectionOption2> options(BuildContext context) {
    return _data.map((model) {
      return SelectionOption2(
        key: model.key,
        label: _getText(context, model.key),
        iconUrl: model.url,
      );
    }).toList();
  }

  void updateKey(KanaType pSelectedKey) {
    selectedKey = pSelectedKey;
    _controller.updateKanaTypeSelected(pSelectedKey);
    notifyListeners();
  }

  String _getText(BuildContext context, KanaType key) {
    final JStrings strings = JStrings.of(context)!;
    if (key.isOnlyHiragana) return strings.settingsOnlyHiragana;
    if (key.isOnlyKatakana) return strings.settingsOnlyKatakana;
    if (key.isBoth) return strings.settingsOnlyHiraganaKatakana;
    return "";
  }
}
