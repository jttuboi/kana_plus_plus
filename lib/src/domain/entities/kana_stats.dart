import 'package:hive/hive.dart';
import 'package:kana_plus_plus/src/domain/entities/stroke_stats.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_result.dart';

part 'kana_stats.g.dart';

@HiveType(typeId: 2)
class KanaStats {
  const KanaStats({
    required this.id,
    required this.correct,
    required this.idWrote,
    required this.strokes,
  });

  factory KanaStats.fromKanaResult(KanaResult kana) {
    return KanaStats(
      id: kana.id,
      correct: kana.isCorrect,
      idWrote: kana.idWrote,
      strokes: kana.strokesDrew.map((stroke) => StrokeStats.fromListOffset(stroke)).toList(),
    );
  }

  @HiveField(0)
  final String id;
  @HiveField(1)
  final bool correct;
  @HiveField(2)
  final String idWrote;
  @HiveField(3)
  final List<StrokeStats> strokes;

  @override
  String toString() {
    return 'KanaStats($id, $correct, $idWrote, $strokes)';
  }
}
