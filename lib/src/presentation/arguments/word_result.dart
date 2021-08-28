import 'package:kana_plus_plus/src/presentation/arguments/kana_result.dart';

class WordResult {
  WordResult({
    required this.id,
    required this.text,
    required this.imageUrl,
    required this.kanas,
  });

  final int id;
  final String text;
  final String imageUrl;
  final List<KanaResult> kanas;

  @override
  String toString() {
    return 'WordResult($id, $text, $imageUrl, $kanas)';
  }
}
