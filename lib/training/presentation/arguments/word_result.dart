import 'package:kwriting/training/domain/entities/word_viewer_content.dart';
import 'package:kwriting/training/presentation/arguments/kana_result.dart';

class WordResult {
  const WordResult({
    required this.id,
    required this.imageUrl,
    required this.kanas,
  });

  factory WordResult.fromWordViewerContent(WordViewerContent wordContent) {
    return WordResult(
      id: wordContent.id,
      imageUrl: wordContent.imageUrl,
      kanas: wordContent.kanas.map((kanaContent) => KanaResult.fromKanaViewerContent(kanaContent)).toList(),
    );
  }

  final String id;
  final String imageUrl;
  final List<KanaResult> kanas;

  @override
  String toString() {
    return 'WordResult($id, $imageUrl, $kanas)';
  }
}
