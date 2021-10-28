import 'package:flutter/foundation.dart';
import 'package:kwriting/settings/settings.dart';

class ShowHintProvider extends ChangeNotifier {
  ShowHintProvider(this._controller);

  final SettingsController _controller;

  bool get showHint => _controller.showHintSelected;

  String get iconUrl => _controller.showHintIconUrl;

  void updateShowHint(bool pIsShowHint) {
    _controller.updateShowHintSelected(pIsShowHint);
    notifyListeners();
  }
}
