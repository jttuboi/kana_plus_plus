import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';

class WordViewerContent {
  const WordViewerContent({
    required this.id,
    required this.wordImageUrl,
    required this.kanas,
  });

  final int id;
  final String wordImageUrl;
  final List<KanaViewerContent> kanas;

  @override
  String toString() {
    return "WordV($id, $wordImageUrl, $kanas)";
  }
}
