import 'package:flutter/widgets.dart';

import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';
import 'package:kana_plus_plus/src/views/android/view_models/selection_option.view_model.dart';
import 'package:kana_plus_plus/src/models/writing_hand.model.dart';
import 'package:kana_plus_plus/src/shared/writing_hand.dart';

class WritingHandProvider extends ChangeNotifier {
  WritingHandProvider(this._controller) {
    _data = _controller.getWritingHandData();
    selectedKey = _controller.getWritingHandSelected();
    notifyListeners();
  }

  final SettingsController _controller;
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
    _controller.updateWritingHandSelected(pSelectedKey);
    notifyListeners();
  }

  String _getText(BuildContext context, WritingHand key) {
    final JStrings strings = JStrings.of(context)!;
    if (key.isLeft) {
      return strings.settingsWritingHandLeft;
    }
    if (key.isRight) {
      return strings.settingsWritingHandRight;
    }
    return "";
  }
}
