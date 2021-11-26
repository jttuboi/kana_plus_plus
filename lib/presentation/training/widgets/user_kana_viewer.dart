import 'dart:ui';

import 'package:flutter/material.dart';

class UserKanaViewer extends StatelessWidget {
  const UserKanaViewer({
    required this.userStrokes,
    required this.size,
    this.strokeWidth = 5.0,
    Key? key,
  }) : super(key: key);

  final List<List<Offset>> userStrokes;
  final Size size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: _UserKanaPainter(userStrokes, strokeWidth),
    );
  }
}

class _UserKanaPainter extends CustomPainter {
  const _UserKanaPainter(
    this.strokesNormalized,
    this.strokeWidth,
  );

  final List<List<Offset>> strokesNormalized;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    for (final pointsNormalized in strokesNormalized) {
      final points = pointsNormalized.map((pointNormalized) {
        return Offset(
          pointNormalized.dx * size.width,
          pointNormalized.dy * size.height,
        );
      }).toList();
      canvas.drawPoints(
        PointMode.polygon,
        points,
        Paint()
          ..isAntiAlias = true
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = Colors.black
          ..strokeWidth = strokeWidth,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
