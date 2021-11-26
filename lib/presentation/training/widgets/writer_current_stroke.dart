import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class WriteCurrentStroke extends StatefulWidget {
  const WriteCurrentStroke({
    required this.canGesture,
    required this.regionSize,
    required this.strokeForDraw,
    required this.onStrokeEnded,
    Key? key,
  }) : super(key: key);

  final bool canGesture;
  final double regionSize;
  final String strokeForDraw;
  final Function(List<Offset> stroke) onStrokeEnded;

  @override
  State<WriteCurrentStroke> createState() => _WriteCurrentStrokeState();
}

class _WriteCurrentStrokeState extends State<WriteCurrentStroke> {
  List<Offset> currentStroke = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.regionSize,
      height: widget.regionSize,
      child: GestureDetector(
        onPanStart: widget.canGesture ? (details) => _startStroke(details, context, widget.regionSize) : null,
        onPanUpdate: widget.canGesture ? (details) => _updateStroke(details, context, widget.regionSize) : null,
        onPanEnd: widget.canGesture ? (details) => _finishStroke(context) : null,
        child: RepaintBoundary(
          child: CustomPaint(
            isComplex: true,
            painter: CurrentStrokePainter(currentStroke, widget.strokeForDraw),
          ),
        ),
      ),
    );
  }

  void _startStroke(DragStartDetails details, BuildContext context, double size) {
    setState(() {
      currentStroke.add(details.localPosition);
    });
  }

  void _updateStroke(DragUpdateDetails details, BuildContext context, double maxSize) {
    final offset = details.localPosition;
    if (0 < offset.dx && offset.dx < maxSize && 0 < offset.dy && offset.dy < maxSize) {
      setState(() {
        currentStroke.add(offset);
      });
    }
  }

  void _finishStroke(BuildContext context) {
    widget.onStrokeEnded(currentStroke);
    setState(() {
      currentStroke = <Offset>[];
    });
  }
}

class CurrentStrokePainter extends CustomPainter {
  const CurrentStrokePainter(this.points, this.stroke);

  final List<Offset> points;
  final String stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final m = Matrix4.identity()..scale(size.width / 109);
    final f = Float64List.fromList(m.storage.toList());

    canvas
      ..drawPoints(PointMode.polygon, points, _strokeBackgroundPaint)
      ..drawPath(parseSvgPath(stroke).transform(f), _strokePaintSvg)
      ..drawPoints(PointMode.polygon, points, _strokeForegroundPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  Paint get _strokeBackgroundPaint => Paint()
    ..isAntiAlias = true
    ..strokeWidth = 18
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..color = Colors.yellow;

  Paint get _strokePaintSvg {
    return Paint()
      ..color = Colors.grey
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  Paint get _strokeForegroundPaint => Paint()
    ..isAntiAlias = true
    ..strokeWidth = 18
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..color = Colors.yellow
    ..blendMode = BlendMode.color;
}
