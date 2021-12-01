import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:kwriting/domain/domain.dart';

part 'kana_stats.g.dart';

@HiveType(typeId: 2)
class KanaStats extends Equatable {
  const KanaStats({
    required this.id,
    required this.correct,
    required this.strokes,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final bool correct;
  @HiveField(2)
  final List<StrokeStats> strokes;

  @override
  List<Object?> get props => [id, correct, strokes];

  @override
  String toString() {
    return 'KanaStats($id, $correct, $strokes)';
  }
}
