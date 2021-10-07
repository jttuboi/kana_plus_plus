import 'package:hive/hive.dart';
import 'package:kwriting/src/domain/entities/word_stats.dart';
import 'package:kwriting/src/domain/utils/kana_type.dart';
import 'package:kwriting/src/presentation/arguments/word_result.dart';

part 'training_stats.g.dart';

@HiveType(typeId: 0)
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

  @HiveField(0)
  final bool showHint;
  @HiveField(1)
  final KanaType type;
  @HiveField(2)
  final int wordsQuantity;
  @HiveField(3)
  final List<WordStats> words;

  @override
  String toString() {
    return 'TrainingStats($showHint, ${type.toString()}, $wordsQuantity, $words)';
  }
}
