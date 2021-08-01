import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';

class WritingHandProvider extends ChangeNotifier {
  WritingHandProvider(this._controller);

  final SettingsController _controller;

  WritingHand get writingHand => _controller.getWritingHandSelected();

  String get iconUrl => _controller.getWritingHandIconUrl();

  List<SelectionOptionArguments> getOptions(
      String Function(WritingHand writingHand) writingHandText) {
    return _controller.getWritingHandData().map((model) {
      return SelectionOptionArguments(
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
