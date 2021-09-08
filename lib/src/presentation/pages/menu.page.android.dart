import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(painter: MenuBackgroundPainter(), size: MediaQuery.of(context).size),
          const _MenuContent(),
        ],
      ),
    );
  }
}

class _MenuContent extends StatelessWidget {
  const _MenuContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Flexible(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(appTitle.toUpperCase(), textAlign: TextAlign.center, style: menuTitleTextStyle),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: GridView.count(
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.study),
                  child: const Icon(Icons.menu_book, size: 80),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.preTraining),
                  child: const Icon(Icons.mode_edit, size: 80),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.words),
                  child: const Icon(Icons.style, size: 80),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.settings),
                  child: const Icon(Icons.settings, size: 80),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTRB(0.0, 0.0, size.width, size.height), Paint()..color = Colors.deepPurple.shade200);

    canvas.drawPath(
      Path()
        ..lineTo(0.0, size.height)
        ..lineTo(0.0 + 20.0, size.height)
        ..quadraticBezierTo(0.0 + 50.0, size.height / 2 + 50.0, size.width, size.height / 2 + 20.0)
        ..lineTo(size.width, 0),
      Paint()..color = Colors.deepPurple.shade400,
    );

    canvas.drawPath(
      Path()
        ..lineTo(0.0, size.height)
        ..lineTo(0.0 + 20.0, size.height)
        ..quadraticBezierTo(0.0 + 50.0, size.height / 2 + 50.0, size.width, size.height / 2 + 20.0)
        ..lineTo(size.width, 0),
      Paint()
        ..color = Colors.black87
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15),
    );

    canvas.drawPath(
      Path()
        ..lineTo(0.0, size.height / 2 - 20.0)
        ..quadraticBezierTo(size.width - 50.0, size.height / 2 - 50.0, size.width - 20.0, 0.0),
      Paint()..color = Colors.black54,
    );

    canvas.drawPath(
      Path()
        ..lineTo(0.0, size.height / 2 - 20.0)
        ..quadraticBezierTo(size.width - 50.0, size.height / 2 - 50.0, size.width - 20.0, 0.0),
      Paint()
        ..color = Colors.black87
        ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 15),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
