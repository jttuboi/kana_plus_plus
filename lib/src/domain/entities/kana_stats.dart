import 'package:kana_plus_plus/src/domain/entities/stroke_stats.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_result.dart';

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

  final String id;
  final bool correct;
  final String idWrote;
  final List<StrokeStats> strokes;

  @override
  String toString() {
    return 'KanaStats($id, $correct, $idWrote, $strokes)';
  }
}
