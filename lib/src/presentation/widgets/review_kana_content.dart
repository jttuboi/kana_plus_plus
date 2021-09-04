import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_result.dart';
import 'package:kana_plus_plus/src/presentation/widgets/border_painter.dart';
import 'package:kana_plus_plus/src/presentation/widgets/user_kana_viewer.dart';

class ReviewKanaContent extends StatelessWidget {
  const ReviewKanaContent({
    Key? key,
    required this.kanaResult,
  }) : super(key: key);

  final KanaResult kanaResult;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32.0,
      child: Stack(
        children: [
          CustomPaint(
            painter: BorderPainter(borderWidth: 1.0, borderColor: (kanaResult.isCorrect) ? Colors.blueAccent : Colors.redAccent),
            size: const Size(32.0, 32.0),
          ),
          UserKanaViewer(
            strokes: kanaResult.strokesDrew,
            size: const Size(32.0, 32.0),
            strokeWidth: 2.0,
          ),
        ],
      ),
    );
  }
}
