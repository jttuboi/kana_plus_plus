import 'package:flutter/foundation.dart';
import 'package:kwriting/features/settings/settings.dart';

class ShowHintChangeNotifier extends ChangeNotifier {
  ShowHintChangeNotifier(this._controller);

  final SettingsController _controller;

  bool get showHint => _controller.showHintSelected;

  String get iconUrl => _controller.showHintIconUrl;

  void updateShowHint(bool pIsShowHint) {
    _controller.updateShowHintSelected(pIsShowHint);
    notifyListeners();
  }
}
