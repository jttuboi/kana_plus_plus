import 'dart:ui';

import 'package:flutter/material.dart';

class UserKanaPainter extends CustomPainter {
  const UserKanaPainter({
    required this.strokes,
    required this.strokeWidth,
  });

  final List<List<Offset>> strokes;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    for (final stroke in strokes) {
      final points = stroke.map((point) => Offset(point.dx * size.width, point.dy * size.height)).toList();
      canvas.drawPoints(PointMode.polygon, points, strokesPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  Paint get strokesPaint => Paint()
    ..color = Colors.black
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
