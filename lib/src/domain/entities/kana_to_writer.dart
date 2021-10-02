import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/domain/utils/kana_type.dart';

class KanaToWrite {
  const KanaToWrite({
    required this.id,
    required this.type,
    required this.hintImageUrl,
    required this.maxStrokes,
  });

  const KanaToWrite.empty()
      : id = '',
        type = KanaType.none,
        hintImageUrl = ImageUrl.empty,
        maxStrokes = 0;

  final String id;
  final KanaType type;
  final String hintImageUrl;
  final int maxStrokes;

  @override
  String toString() {
    return 'KanaToWrite($id, $type, $hintImageUrl, $maxStrokes)';
  }
}
