import 'package:hive/hive.dart';
import 'package:kwriting/training/domain/entities/kana_stats.dart';
import 'package:kwriting/training/presentation/arguments/word_result.dart';

part 'word_stats.g.dart';

@HiveType(typeId: 1)
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

  @HiveField(0)
  final String id;
  @HiveField(1)
  final bool correct;
  @HiveField(2)
  final List<KanaStats> kanas;

  @override
  String toString() {
    return 'WordStats($id, $correct, $kanas)';
  }
}
