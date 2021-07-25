import 'package:flutter/widgets.dart';

import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';
import 'package:kana_plus_plus/src/models/writing_hand.model.dart';
import 'package:kana_plus_plus/src/shared/writing_hand.dart';
import 'package:kana_plus_plus/src/views/android/pages/settings.page.dart';

class WritingHandProvider extends ChangeNotifier {
  WritingHandProvider(this.controller) {
    _data = controller.getWritingHands();
    selectedWritingHandKey = controller.getSelectedWritingHandKey();
    notifyListeners();
  }

  SettingsController controller;

  late List<WritingHandModel> _data;

  late WritingHand selectedWritingHandKey;

  String get writingHandIconUrl {
    return _data.firstWhere((model) {
      return model.key.equal(selectedWritingHandKey);
    }).url;
  }

  String writingHandText(BuildContext context) {
    return _getWritingHandText(context, selectedWritingHandKey);
  }

  List<SelectionOption2> writingHandOptions(BuildContext context) {
    return _data.map((model) {
      return SelectionOption2(
        model.key,
        _getWritingHandText(context, model.key),
        iconUrl: model.url,
      );
    }).toList();
  }

  void changeWritingHand(WritingHand pSelectedWritingHandKey) {
    selectedWritingHandKey = pSelectedWritingHandKey;
    controller.updateWritingHand(pSelectedWritingHandKey);
    notifyListeners();
  }

  String _getWritingHandText(BuildContext context, WritingHand key) {
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
