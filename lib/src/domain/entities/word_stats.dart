import 'package:kana_plus_plus/src/domain/entities/kana_stats.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';

class WordStats {
  const WordStats({
    required this.id,
    required this.correct,
    required this.kanas,
  });

  factory WordStats.fromWordResult(WordResult word) {
    final kanas = word.kanas.map((kana) => KanaStats.fromKanaResult(kana)).toList();
    final correct = kanas.indexWhere((kana) => kana.correct == false) == -1;
    return WordStats(
      id: word.id,
      correct: correct,
      kanas: kanas,
    );
  }

  final String id;
  final bool correct;
  final List<KanaStats> kanas;

  @override
  String toString() {
    return 'WordStats($id, $correct, $kanas)';
  }
}
