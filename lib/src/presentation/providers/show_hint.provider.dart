import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/settings.controller.dart';

class ShowHintProvider extends ChangeNotifier {
  ShowHintProvider(this._controller) {
    isShowHint = _controller.isShowHint();
    notifyListeners();
  }

  final SettingsController _controller;

  late bool isShowHint;

  String get iconUrl => _controller.getShowHintIconUrl(isShowHint);

  void updateShowHint(bool pIsShowHint) {
    isShowHint = pIsShowHint;
    _controller.updateShowHint(pIsShowHint);
    notifyListeners();
  }
}
