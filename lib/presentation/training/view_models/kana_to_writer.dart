import 'package:kwriting/domain/domain.dart';

class KanaToWrite {
  const KanaToWrite({
    required this.id,
    required this.type,
    required this.hintImageUrl,
    required this.maxStrokes,
  });

  const KanaToWrite.empty()
      : id = '',
        type = KanaType.both,
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
