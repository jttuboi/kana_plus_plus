import 'dart:ui';

import 'package:hive/hive.dart';

part 'point_stats.g.dart';

@HiveType(typeId: 4)
class PointStats {
  PointStats({
    required this.x,
    required this.y,
  });

  factory PointStats.fromOffset(Offset point) {
    return PointStats(x: point.dx, y: point.dy);
  }

  @HiveField(0)
  final double x;
  @HiveField(1)
  final double y;
}
