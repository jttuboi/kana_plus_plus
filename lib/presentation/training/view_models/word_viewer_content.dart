import 'package:kwriting/presentation/training/training.dart';

class WordViewerContent {
  WordViewerContent({
    required this.id,
    required this.imageUrl,
    required this.translate,
    required this.kanas,
  });

  factory WordViewerContent.fromWord(Word word) {
    return WordViewerContent(
      id: word.id,
      imageUrl: word.imageUrl,
      translate: word.translate,
      kanas: word.kanas.asMap().entries.map((entry) => KanaViewerContent.fromKana(entry.value, entry.key == 0)).toList(),
    );
  }

  final String id;
  final String imageUrl;
  final String translate;
  final List<KanaViewerContent> kanas;

  @override
  String toString() {
    return 'WordViewer($id, $imageUrl, $translate, $kanas)';
  }
}
