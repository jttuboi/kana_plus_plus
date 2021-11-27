import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class Writer extends StatelessWidget {
  const Writer({
    required this.squareSize,
    required this.borderSize,
    Key? key,
  })  : regionTapSize = squareSize - borderSize * 2,
        super(key: key);

  final double squareSize;
  final double borderSize;
  final double regionTapSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: BorderPainter(borderSize: borderSize, borderColor: Colors.grey.shade500),
          size: Size.square(squareSize),
        ),
        Positioned(
          top: borderSize,
          left: borderSize,
          child: BlocBuilder<WriterBloc, WriterState>(
            builder: (context, state) {
              if (state is WriterWait || state is WriterEnd) {
                return CustomPaint(
                  size: Size.square(regionTapSize),
                  painter: _AllStrokesPainter(state.strokesForDraw, state.userStrokes, state.corrects),
                );
              }
              return Container();
            },
          ),
        ),
        Positioned(
          top: borderSize,
          left: borderSize,
          child: BlocBuilder<WriterBloc, WriterState>(
            builder: (context, state) {
              if (state is WriterWait) {
                return WriteCurrentStroke(
                    canGesture: state is WriterWait,
                    regionSize: regionTapSize,
                    strokeForDraw: state.strokesForDraw[state.currentIndexStroke],
                    onStrokeEnded: (stroke) {
                      context.read<WriterBloc>().add(StrokeWritten(stroke, regionTapSize));
                    });
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}

class _AllStrokesPainter extends CustomPainter {
  const _AllStrokesPainter(this.strokes, this.userStrokes, this.corrects);

  final List<String> strokes;
  final List<List<Offset>> userStrokes;
  final List<bool> corrects;

  @override
  void paint(Canvas canvas, Size size) {
    final m = Matrix4.identity()..scale(size.width / 109);
    final f = Float64List.fromList(m.storage.toList());

    for (var i = 0; i < corrects.length; i++) {
      final points = userStrokes[i].map((point) => Offset(point.dx * size.width, point.dy * size.height)).toList();
      canvas.drawPoints(PointMode.polygon, points, _userStrokeBackgroundPaint(i));
    }

    for (var i = 0; i < corrects.length; i++) {
      canvas.drawPath(parseSvgPath(strokes[i]).transform(f), _strokePaint(i));
    }

    for (var i = 0; i < corrects.length; i++) {
      final points = userStrokes[i].map((point) => Offset(point.dx * size.width, point.dy * size.height)).toList();
      canvas.drawPoints(PointMode.polygon, points, _userStrokeForegroundPaint(i));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  Paint _userStrokeBackgroundPaint(int index) {
    return (corrects[index])
        ? (_basePaint
          ..color = Colors.blue.shade50
          ..strokeWidth = 16)
        : (_basePaint
          ..color = Colors.red.shade50
          ..strokeWidth = 16);
  }

  Paint _strokePaint(int index) {
    return (corrects[index])
        ? (_basePaint
          ..color = Colors.grey //blue
          ..strokeWidth = 20)
        : (_basePaint
          ..color = Colors.grey //red
          ..strokeWidth = 20);
  }

  Paint _userStrokeForegroundPaint(int index) {
    return (corrects[index])
        ? (_basePaint
          ..color = Colors.blueAccent
          ..strokeWidth = 16
          ..blendMode = BlendMode.color)
        : (_basePaint
          ..color = Colors.redAccent
          ..strokeWidth = 16
          ..blendMode = BlendMode.color);
  }

  Paint get _basePaint => Paint()
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;
}
