import 'package:flutter/widgets.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class KanaTypeChangeNotifier extends ChangeNotifier {
  KanaTypeChangeNotifier(IKanaTypeRepository kanaTypeRepository, {this.mustPersist = true}) {
    _getKanaType = GetKanaType(kanaTypeRepository);
    _updateKanaType = UpdateKanaType(kanaTypeRepository);

    _getKanaType(NoParams()).then((kanaType) {
      data = KanaTypeData(kanaType: kanaType, iconUrl: _findIconUrl(kanaType));
      notifyListeners();
    });
  }

  final bool mustPersist;
  late final GetKanaType _getKanaType;
  late final UpdateKanaType _updateKanaType;

  KanaTypeData data = KanaTypeData.empty;

  List<KanaTypeData> get kanaTypesData => [
        const KanaTypeData(kanaType: KanaType.hiragana, iconUrl: IconUrl.hiragana),
        const KanaTypeData(kanaType: KanaType.katakana, iconUrl: IconUrl.katakana),
        const KanaTypeData(kanaType: KanaType.both, iconUrl: IconUrl.both),
      ];

  void updateKanaType(KanaType kanaType) {
    data = KanaTypeData(kanaType: kanaType, iconUrl: _findIconUrl(kanaType));
    if (mustPersist) {
      _updateKanaType(KanaTypeParams(kanaType));
    }
    notifyListeners();
  }

  String _findIconUrl(KanaType kanaType) {
    return kanaTypesData.firstWhere((data) => data.kanaType.equal(kanaType)).iconUrl;
  }
}
