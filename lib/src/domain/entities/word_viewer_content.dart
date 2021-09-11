import 'package:kana_plus_plus/src/domain/entities/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/domain/entities/word.dart';

class WordViewerContent {
  WordViewerContent({
    required this.id,
    required this.imageUrl,
    required this.kanas,
  });

  factory WordViewerContent.fromWord(Word word) {
    return WordViewerContent(
      id: word.id,
      imageUrl: word.imageUrl,
      kanas: word.kanas.asMap().entries.map((entry) => KanaViewerContent.fromKana(entry.value, entry.key == 0)).toList(),
    );
  }

  final String id;
  final String imageUrl;
  final List<KanaViewerContent> kanas;

  @override
  String toString() {
    return 'WordViewer($id, $imageUrl, $kanas)';
  }
}