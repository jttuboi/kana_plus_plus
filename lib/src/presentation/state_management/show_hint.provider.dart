import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';

class ShowHintProvider extends ChangeNotifier {
  ShowHintProvider(this._controller);

  final SettingsController _controller;

  bool get showHint => _controller.isShowHint();

  String get iconUrl => _controller.getShowHintIconUrl();

  void updateShowHint(bool pIsShowHint) {
    _controller.updateShowHint(pIsShowHint);
    notifyListeners();
  }
}
