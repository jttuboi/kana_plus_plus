import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

class ReviewKanaContent extends StatelessWidget {
  const ReviewKanaContent({required this.kanaResult, Key? key}) : super(key: key);

  final KanaViewModel kanaResult;

  double get _squareSize => 32;
  double get _borderSize => 1;
  double get _squareTapSize => _squareSize - _borderSize * 2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _squareSize,
      child: Stack(
        children: [
          CustomPaint(
            painter: BorderPainter(borderSize: _borderSize, borderColor: (kanaResult.status.isCorrect) ? Colors.blueAccent : Colors.redAccent),
            size: Size.square(_squareSize),
          ),
          Positioned(
            top: _borderSize,
            left: _borderSize,
            child: CustomPaint(
              painter: UserKanaPainter(strokes: kanaResult.userStrokes, strokeWidth: 1),
              size: Size.square(_squareTapSize),
            ),
          ),
        ],
      ),
    );
  }
}
