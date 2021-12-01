import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:kwriting/domain/domain.dart';

part 'word_stats.g.dart';

@HiveType(typeId: 1)
class WordStats extends Equatable {
  const WordStats({
    required this.id,
    required this.correct,
    required this.kanas,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final bool correct;
  @HiveField(2)
  final List<KanaStats> kanas;

  @override
  List<Object?> get props => [id, correct, kanas];

  @override
  String toString() {
    return 'WordStats($id, $correct, $kanas)';
  }
}
