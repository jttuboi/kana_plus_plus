import 'package:flutter/foundation.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';

class ShowHintChangeNotifier extends ChangeNotifier {
  ShowHintChangeNotifier(this.showHintRepository, {this.mustPersist = true}) {
    showHintRepository.getShowHint().then((showHint) {
      data = ShowHintViewModel(showHint: showHint, iconUrl: _findIconUrl(showHint));
      notifyListeners();
    });
  }

  final bool mustPersist;
  final IShowHintRepository showHintRepository;

  ShowHintViewModel data = ShowHintViewModel.empty;

  void updateShowHint(bool showHint) {
    data = ShowHintViewModel(showHint: showHint, iconUrl: _findIconUrl(showHint));
    if (mustPersist) {
      showHintRepository.updateShowHint(showHint);
    }
    notifyListeners();
  }

  String _findIconUrl(bool showHint) {
    return showHint ? IconUrl.showHint : IconUrl.notShowHint;
  }
}
