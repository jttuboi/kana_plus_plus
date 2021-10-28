import 'package:flutter/material.dart';
import 'package:kwriting/menu/menu.dart';

class MenuBackground extends StatefulWidget {
  const MenuBackground({Key? key}) : super(key: key);

  @override
  _MenuBackgroundState createState() => _MenuBackgroundState();
}

class _MenuBackgroundState extends State<MenuBackground> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        CustomPaint(painter: _Layer0Painter(), size: MediaQuery.of(context).size),
        FallingKanaAnimation(
          initialPosition: Offset(width * 1 / 5, height * 1 / 3),
          endYPosition: height,
          durationInMilliseconds: 9000,
          kanaSize: 52,
          kanaColor: Colors.grey.shade700,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 3 / 8, height * 1 / 3),
          endYPosition: height * 69 / 70,
          durationInMilliseconds: 7000,
          kanaSize: 45,
          kanaColor: Colors.grey.shade700,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 2 / 3, height * 1 / 3),
          endYPosition: height * 77 / 80,
          durationInMilliseconds: 10000,
          kanaSize: 68,
          kanaColor: Colors.grey.shade700,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 3 / 5, height * 1 / 10),
          endYPosition: height * 77 / 80,
          durationInMilliseconds: 13000,
          kanaSize: 32,
          kanaColor: Colors.grey.shade700,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 7 / 8, height * 1 / 3),
          endYPosition: height * 57 / 60,
          durationInMilliseconds: 8000,
          kanaSize: 48,
          kanaColor: Colors.grey.shade700,
        ),
        CustomPaint(painter: _Layer1Painter(), size: MediaQuery.of(context).size),
        FallingKanaAnimation(
          initialPosition: Offset(width * 1 / 80, height * 1 / 3),
          endYPosition: height * 12 / 13,
          durationInMilliseconds: 8000,
          kanaSize: 40,
          kanaColor: Colors.grey.shade600,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 2 / 11, height * 3 / 10),
          endYPosition: height * 6 / 7,
          durationInMilliseconds: 4000,
          kanaSize: 35,
          kanaColor: Colors.grey.shade700,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 2 / 7, 0),
          endYPosition: height * 5 / 9,
          durationInMilliseconds: 9000,
          kanaSize: 80,
          kanaColor: Colors.grey.shade600,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 4 / 7, height * 1 / 5),
          endYPosition: height * 2 / 3,
          durationInMilliseconds: 5000,
          kanaSize: 60,
          kanaColor: Colors.grey.shade700,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 12 / 13, -40),
          endYPosition: height * 2 / 3,
          durationInMilliseconds: 6000,
          kanaSize: 35,
          kanaColor: Colors.grey.shade600,
        ),
        CustomPaint(painter: _Layer2Painter(), size: MediaQuery.of(context).size),
        FallingKanaAnimation(
          initialPosition: Offset(width * 1 / 20, -100),
          endYPosition: height * 3 / 4,
          durationInMilliseconds: 7000,
          kanaSize: 50,
          kanaColor: Colors.grey.shade400,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 1 / 5, -100),
          endYPosition: height * 2 / 3,
          durationInMilliseconds: 5000,
          kanaSize: 45,
          kanaColor: Colors.grey.shade400,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 1 / 3, -100),
          endYPosition: height * 3 / 5,
          durationInMilliseconds: 8500,
          kanaSize: 55,
          kanaColor: Colors.grey.shade300,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 4 / 7, -100),
          endYPosition: height * 1 / 2,
          durationInMilliseconds: 4500,
          kanaSize: 33,
          kanaColor: Colors.grey.shade400,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 3 / 4, -100),
          endYPosition: height * 3 / 5,
          durationInMilliseconds: 9000,
          kanaSize: 60,
          kanaColor: Colors.grey.shade300,
        ),
        FallingKanaAnimation(
          initialPosition: Offset(width * 6 / 7, -100),
          endYPosition: height * 1 / 2,
          durationInMilliseconds: 6500,
          kanaSize: 50,
          kanaColor: Colors.grey.shade400,
        ),
      ],
    );
  }
}

class _Layer0Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height),
      Paint()..color = Colors.deepPurple.shade200,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _Layer1Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawPath(
        Path()
          ..lineTo(0, size.height)
          ..lineTo(0 + 20, size.height)
          ..quadraticBezierTo(0 + 50, size.height / 2 + 50, size.width, size.height / 2 + 20)
          ..lineTo(size.width, 0)
          ..close(),
        Paint()..color = Colors.deepPurple.shade400,
      )
      ..drawPath(
        Path()
          ..lineTo(0, size.height)
          ..lineTo(0 + 20, size.height)
          ..quadraticBezierTo(0 + 50, size.height / 2 + 50, size.width, size.height / 2 + 20)
          ..lineTo(size.width, 0)
          ..close(),
        Paint()
          ..color = Colors.black87
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10),
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class _Layer2Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawPath(
        Path()
          ..lineTo(0, size.height / 2 - 20)
          ..quadraticBezierTo(size.width - 50, size.height / 2 - 50, size.width - 20, 0)
          ..close(),
        Paint()..color = const Color.fromRGBO(58, 39, 89, 1),
      )
      ..drawPath(
        Path()
          ..lineTo(0, size.height / 2 - 20)
          ..quadraticBezierTo(size.width - 50, size.height / 2 - 50, size.width - 20, 0)
          ..close(),
        Paint()
          ..color = Colors.black87
          ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10),
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
