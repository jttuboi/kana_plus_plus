import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserKanaViewer extends StatelessWidget {
  const UserKanaViewer({
    Key? key,
    required this.strokes,
    required this.size,
    this.strokeWidth = 5.0,
    this.strokeColor = Colors.black,
  }) : super(key: key);

  final List<List<Offset>> strokes;
  final Size size;
  final double strokeWidth;
  final Color strokeColor;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      painter: _UserKanaPainter(strokes, strokeWidth, strokeColor),
    );
  }
}

class _UserKanaPainter extends CustomPainter {
  const _UserKanaPainter(
    this.strokesNormalized,
    this.strokeWidth,
    this.strokeColor,
  );

  final List<List<Offset>> strokesNormalized;
  final double strokeWidth;
  final Color strokeColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = strokeColor;

    for (final pointsNormalized in strokesNormalized) {
      final points = pointsNormalized.map((pointNormalized) {
        return Offset(
          pointNormalized.dx * size.width,
          pointNormalized.dy * size.height,
        );
      }).toList();
      canvas.drawPoints(PointMode.polygon, points, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
