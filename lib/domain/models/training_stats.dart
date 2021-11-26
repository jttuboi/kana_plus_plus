import 'package:hive/hive.dart';
import 'package:kwriting/domain/domain.dart';

part 'training_stats.g.dart';

@HiveType(typeId: 0)
class TrainingStats {
  const TrainingStats({
    required this.showHint,
    required this.type,
    required this.wordsQuantity,
    required this.words,
  });

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
