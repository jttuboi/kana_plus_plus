import 'dart:ui';

import 'package:hive/hive.dart';
import 'package:kwriting/domain/domain.dart';

part 'stroke_stats.g.dart';

@HiveType(typeId: 3)
class StrokeStats {
  const StrokeStats({
    required this.points,
  });

  factory StrokeStats.fromListOffset(List<Offset> stroke) {
    return StrokeStats(points: stroke.map((point) => PointStats.fromOffset(point)).toList());
  }

  @HiveField(0)
  final List<PointStats> points;

  @override
  String toString() {
    return 'StrokeStats($points)';
  }
}