import 'dart:ui';

class StrokeStats {
  const StrokeStats({
    required this.points,
  });

  factory StrokeStats.fromListOffset(List<Offset> stroke) {
    return StrokeStats(points: stroke);
  }

  final List<Offset> points;

  @override
  String toString() {
    return 'StrokeStats($points)';
  }
}
