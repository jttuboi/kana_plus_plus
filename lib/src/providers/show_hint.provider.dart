import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';

class ShowHintProvider extends ChangeNotifier {
  ShowHintProvider(this.controller) {
    controller.getShowHint().then((value) {
      _showHint = value;
      notifyListeners();
    });
  }

  SettingsController controller;

  bool _showHint = false;

  bool get showHint {
    controller.getShowHint().then((value) {
      _showHint = value;
      notifyListeners();
    });
    return _showHint;
  }

  String get showHintIconUrl {
    return controller.getShowHintIconUrl(_showHint);
  }

  void changeShowHint(bool pShowHint) {
    _showHint = pShowHint;
    controller.updateShowHint(pShowHint);
    notifyListeners();
  }
}
