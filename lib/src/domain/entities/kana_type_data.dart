import 'package:kwriting/src/data/datasources/icon_url.storage.dart';
import 'package:kwriting/src/domain/utils/kana_type.dart';

class KanaTypeData {
  const KanaTypeData({required this.type, required this.iconUrl});

  const KanaTypeData.empty()
      : type = KanaType.none,
        iconUrl = IconUrl.empty;

  final KanaType type;
  final String iconUrl;

  @override
  String toString() {
    return 'KanaTypeData($type, $iconUrl)';
  }
}
