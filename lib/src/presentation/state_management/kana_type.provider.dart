import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/repositories/settings.interface.dart';
import 'package:kana_plus_plus/src/data/models/kana_type.model.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';

class KanaTypeProvider extends ChangeNotifier {
  KanaTypeProvider(this._repository) {
    _data = _repository.getKanaTypeData();
    selectedKey = _repository.getKanaTypeSelected();
    notifyListeners();
  }

  final ISettingsRepository _repository;
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

  List<SelectionOptionArguments> options(BuildContext context) {
    return _data.map((model) {
      return SelectionOptionArguments(
        key: model.key,
        label: _getText(context, model.key),
        iconUrl: model.url,
      );
    }).toList();
  }

  void updateKey(KanaType pSelectedKey) {
    selectedKey = pSelectedKey;
    _repository.saveKanaTypeSelected(pSelectedKey);
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
