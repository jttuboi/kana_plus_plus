import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'point_stats.g.dart';

@HiveType(typeId: 4)
class PointStats extends Equatable {
  const PointStats({
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

  @override
  List<Object?> get props => [x, y];

  @override
  String toString() {
    return 'PointStats($x, $y)';
  }
}
