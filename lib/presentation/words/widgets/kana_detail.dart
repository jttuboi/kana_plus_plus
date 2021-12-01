import 'package:flutter/material.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

class KanaDetail extends StatelessWidget {
  const KanaDetail({
    required this.strokes,
    required this.size,
    Key? key,
  }) : super(key: key);

  final List<String> strokes;
  final double size;

  @override
  Widget build(BuildContext context) {
    const borderSize = 2.0;
    return Container(
      alignment: Alignment.center,
      width: size,
      child: Stack(
        children: [
          CustomPaint(
            painter: BorderPainter(borderSize: borderSize, borderColor: Colors.grey.shade500),
            size: Size.square(size),
          ),
          Positioned(
            top: borderSize,
            left: borderSize,
            child: CustomPaint(
              painter: KanaPainter(borderSize: borderSize, strokes: strokes, strokeWidth: 3),
              size: Size.square(size - borderSize * 2),
            ),
          ),
        ],
      ),
    );
  }
}
