import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';

class WordViewerContent {
  const WordViewerContent({
    required this.id,
    required this.text,
    required this.imageUrl,
    required this.kanas,
  });

  final int id;
  final String text;
  final String imageUrl;
  final List<KanaViewerContent> kanas;

  @override
  String toString() {
    return 'WordV($id, $text, $imageUrl, $kanas)';
  }
}
