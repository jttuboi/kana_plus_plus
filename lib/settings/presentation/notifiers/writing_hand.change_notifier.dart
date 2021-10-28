import 'package:flutter/widgets.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';

class WritingHandChangeNotifier extends ChangeNotifier {
  WritingHandChangeNotifier(this._controller);

  final SettingsController _controller;

  WritingHand get writingHand => _controller.writingHandSelected;

  String get iconUrl => _controller.writingHandIconUrl;

  List<SelectionOptionItem> options(String Function(WritingHand writingHand) writingHandText) {
    return _controller.getWritingHandData.map((model) {
      return SelectionOptionItem(
        key: model.writingHand,
        label: writingHandText(model.writingHand),
        iconUrl: model.iconUrl,
      );
    }).toList();
  }

  void updateWritingHand(WritingHand pSelectedKey) {
    _controller.updateWritingHandSelected(pSelectedKey);
    notifyListeners();
  }
}
