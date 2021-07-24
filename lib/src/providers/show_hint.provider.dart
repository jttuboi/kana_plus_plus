import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';

class ShowHintProvider extends ChangeNotifier {
  ShowHintProvider(this.controller) {
    isShowHint = controller.isShowHint();
    notifyListeners();
  }

  SettingsController controller;

  late bool isShowHint;

  String get showHintIconUrl {
    return controller.getShowHintIconUrl(isShowHint);
  }

  void changeShowHint(bool pShowHint) {
    isShowHint = pShowHint;
    controller.updateShowHint(pShowHint);
    notifyListeners();
  }
}
