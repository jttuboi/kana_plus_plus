import 'package:flutter/material.dart';

class StudyContentPainter extends CustomPainter {
  const StudyContentPainter({required this.empty, required this.leftLetter, required this.rightLetter});

  final bool empty;
  final String leftLetter;
  final String rightLetter;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(-4, 0, size.width + 4, size.height), const Radius.circular(4)),
      Paint()..color = empty ? Colors.transparent : Colors.grey.shade50,
    );

    if (!empty) {
      final leftLetterPainter = TextPainter(
        text: TextSpan(text: leftLetter, style: const TextStyle(fontSize: 16, color: Colors.deepPurple)),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width);
      leftLetterPainter.paint(canvas, Offset(size.width * 1 / 3 - leftLetterPainter.width * 1 / 2, size.height * 1 / 2));

      final rightLetterPainter = TextPainter(
        text: TextSpan(text: rightLetter, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: size.width);
      rightLetterPainter.paint(
          canvas, Offset(size.width * 2 / 3 - rightLetterPainter.width * 1 / 2, size.height * 1 / 2 - rightLetterPainter.height));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
