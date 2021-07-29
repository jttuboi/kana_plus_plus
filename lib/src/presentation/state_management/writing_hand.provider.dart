import 'package:flutter/widgets.dart';

import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/repositories/settings.interface.dart';
import 'package:kana_plus_plus/src/data/models/writing_hand.model.dart';
import 'package:kana_plus_plus/src/presentation/viewmodels/selection_option.viewmodel.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';

class WritingHandProvider extends ChangeNotifier {
  WritingHandProvider(this._repository) {
    _data = _repository.getWritingHandData();
    selectedKey = _repository.getWritingHandSelected();
    notifyListeners();
  }

  final ISettingsRepository _repository;
  late final List<WritingHandModel> _data;

  late WritingHand selectedKey;

  String get iconUrl {
    return _data.firstWhere((model) {
      return model.key.equal(selectedKey);
    }).url;
  }

  String text(BuildContext context) {
    return _getText(context, selectedKey);
  }

  List<SelectionOptionViewModel> options(BuildContext context) {
    return _data.map((model) {
      return SelectionOptionViewModel(
        key: model.key,
        label: _getText(context, model.key),
        iconUrl: model.url,
      );
    }).toList();
  }

  void updateKey(WritingHand pSelectedKey) {
    selectedKey = pSelectedKey;
    _repository.saveWritingHandSelected(pSelectedKey);
    notifyListeners();
  }

  String _getText(BuildContext context, WritingHand key) {
    final JStrings strings = JStrings.of(context)!;
    if (key.isLeft) return strings.settingsWritingHandLeft;
    if (key.isRight) return strings.settingsWritingHandRight;
    return "";
  }
}