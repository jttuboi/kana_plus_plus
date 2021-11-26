import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

class ReviewKanaContent extends StatelessWidget {
  const ReviewKanaContent({required this.kanaResult, Key? key}) : super(key: key);

  final KanaViewModel kanaResult;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Stack(
        children: [
          CustomPaint(
            painter: BorderPainter(borderWidth: 1, borderColor: (kanaResult.status.isCorrect) ? Colors.blueAccent : Colors.redAccent),
            size: const Size(32, 32),
          ),
          UserKanaViewer(
            userStrokes: kanaResult.userStrokes,
            size: const Size(32, 32),
            strokeWidth: 2,
          ),
        ],
      ),
    );
  }
}