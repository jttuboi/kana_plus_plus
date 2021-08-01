import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';

class KanaTypeData {
  const KanaTypeData({required this.kanaType, required this.iconUrl});

  const KanaTypeData.empty()
      : kanaType = KanaType.none,
        // TODO icon
        iconUrl = "";

  final KanaType kanaType;
  final String iconUrl;

  @override
  String toString() {
    return "KanaTypeData($kanaType, $iconUrl)";
  }
}
