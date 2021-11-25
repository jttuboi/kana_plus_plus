import 'package:flutter/widgets.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';

class KanaTypeChangeNotifier extends ChangeNotifier {
  KanaTypeChangeNotifier(this.kanaTypeRepository, {this.mustPersist = true}) {
    kanaTypeRepository.getKanaType().then((kanaType) {
      data = KanaTypeViewModel(kanaType: kanaType, iconUrl: _findIconUrl(kanaType));
      notifyListeners();
    });
  }

  final bool mustPersist;
  final IKanaTypeRepository kanaTypeRepository;

  KanaTypeViewModel data = KanaTypeViewModel.empty;

  List<KanaTypeViewModel> get kanaTypesData => [
        const KanaTypeViewModel(kanaType: KanaType.hiragana, iconUrl: IconUrl.hiragana),
        const KanaTypeViewModel(kanaType: KanaType.katakana, iconUrl: IconUrl.katakana),
        const KanaTypeViewModel(kanaType: KanaType.both, iconUrl: IconUrl.both),
      ];

  void updateKanaType(KanaType kanaType) {
    data = KanaTypeViewModel(kanaType: kanaType, iconUrl: _findIconUrl(kanaType));
    if (mustPersist) {
      kanaTypeRepository.updateKanaType(kanaType);
    }
    notifyListeners();
  }

  String _findIconUrl(KanaType kanaType) {
    return kanaTypesData.firstWhere((data) => data.kanaType.equal(kanaType)).iconUrl;
  }
}
