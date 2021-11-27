import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class KanaPainter extends CustomPainter {
  KanaPainter({
    required this.borderSize,
    required this.strokes,
    required this.strokeWidth,
  });

  final double borderSize;
  final List<String> strokes;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final m = Matrix4.identity()..scale(size.width / 109);
    final f = Float64List.fromList(m.storage.toList());
    for (var p = 0; p < strokes.length; p++) {
      canvas.drawPath(parseSvgPath(strokes[p]).transform(f), pathPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  Paint get pathPaint => Paint()
    ..color = Colors.grey
    ..strokeWidth = strokeWidth
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;
}
