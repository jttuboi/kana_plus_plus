import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';

class WordViewerContent {
  const WordViewerContent({
    required this.id,
    required this.imageUrl,
    required this.kanas,
  });

  final String id;
  final String imageUrl;
  final List<KanaViewerContent> kanas;

  @override
  String toString() {
    return 'WordViewer($id, $imageUrl, $kanas)';
  }
}
