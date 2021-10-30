import 'package:flutter/foundation.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class ShowHintChangeNotifier extends ChangeNotifier {
  ShowHintChangeNotifier(IShowHintRepository showHintRepository) {
    _getShowHint = GetShowHint(showHintRepository);
    _updateShowHint = UpdateShowHint(showHintRepository);

    _getShowHint(NoParams()).then((showHint) {
      data = ShowHintData(showHint: showHint, iconUrl: _findIconUrl(showHint));
      notifyListeners();
    });
  }

  late final GetShowHint _getShowHint;
  late final UpdateShowHint _updateShowHint;

  ShowHintData data = ShowHintData.empty;

  void updateShowHint(bool showHint) {
    data = ShowHintData(showHint: showHint, iconUrl: _findIconUrl(showHint));
    _updateShowHint(ShowHintParams(showHint));
    notifyListeners();
  }

  String _findIconUrl(bool showHint) {
    return showHint ? IconUrl.showHint : IconUrl.notShowHint;
  }
}
