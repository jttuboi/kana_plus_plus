import 'package:kana_plus_plus/src/domain/core/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/word_stats.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';

class TrainingStats {
  const TrainingStats({
    required this.showHint,
    required this.type,
    required this.wordsQuantity,
    required this.words,
  });

  factory TrainingStats.fromWordsResult(bool showHint, KanaType type, int wordsQuantity, List<WordResult> words) {
    return TrainingStats(
      showHint: showHint,
      type: type,
      wordsQuantity: wordsQuantity,
      words: words.map((word) => WordStats.fromWordResult(word)).toList(),
    );
  }

  final bool showHint;
  final KanaType type;
  final int wordsQuantity;
  final List<WordStats> words;

  @override
  String toString() {
    return 'TrainingStats($showHint, ${type.toString()}, $wordsQuantity, $words)';
  }
}
