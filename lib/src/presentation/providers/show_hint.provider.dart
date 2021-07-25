import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/repositories/settings.interface.dart';

class ShowHintProvider extends ChangeNotifier {
  ShowHintProvider(this._repository) {
    isShowHint = _repository.isShowHint();
    notifyListeners();
  }

  final ISettingsRepository _repository;

  late bool isShowHint;

  String get iconUrl => _repository.getShowHintIconUrl(isShowHint);

  void updateShowHint(bool pIsShowHint) {
    isShowHint = pIsShowHint;
    _repository.saveShowHint(pIsShowHint);
    notifyListeners();
  }
}
