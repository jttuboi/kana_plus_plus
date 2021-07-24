import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';

class ShowHintProvider extends ChangeNotifier {
  ShowHintProvider(this.controller) {
    showHint = controller.getShowHint();
    notifyListeners();
  }

  SettingsController controller;

  late bool showHint;

  String get showHintIconUrl {
    return controller.getShowHintIconUrl(showHint);
  }

  void changeShowHint(bool pShowHint) {
    showHint = pShowHint;
    controller.updateShowHint(pShowHint);
    notifyListeners();
  }
}
