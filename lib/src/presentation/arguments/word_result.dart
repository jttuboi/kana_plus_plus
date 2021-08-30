import 'package:kana_plus_plus/src/presentation/arguments/kana_result.dart';

class WordResult {
  WordResult({
    required this.id,
    required this.imageUrl,
    required this.kanas,
  });

  final String id;
  final String imageUrl;
  final List<KanaResult> kanas;

  @override
  String toString() {
    return 'WordResult($id, $imageUrl, $kanas)';
  }
}
