import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

class ReviewKanaContent extends StatelessWidget {
  const ReviewKanaContent({required this.kanaResult, Key? key}) : super(key: key);

  final KanaViewModel kanaResult;

  @override
  Widget build(BuildContext context) {
    const squareSize = 32.0;
    const borderSize = 1.0;
    const squareTapSize = squareSize - borderSize * 2;
    return SizedBox(
      width: squareSize,
      child: Stack(
        children: [
          CustomPaint(
            painter: BorderPainter(borderSize: borderSize, borderColor: (kanaResult.status.isCorrect) ? Colors.blueAccent : Colors.redAccent),
            size: const Size.square(squareSize),
          ),
          Positioned(
            top: borderSize,
            left: borderSize,
            child: CustomPaint(
              painter: UserKanaPainter(strokes: kanaResult.userStrokes, strokeWidth: 1),
              size: const Size.square(squareTapSize),
            ),
          ),
        ],
      ),
    );
  }
}
