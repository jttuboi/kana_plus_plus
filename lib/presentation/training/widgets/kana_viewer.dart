import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

class KanaViewer extends StatelessWidget {
  const KanaViewer(this.kana, {required this.squareSize, Key? key}) : super(key: key);

  final double squareSize;
  final KanaViewModel kana;

  @override
  Widget build(BuildContext context) {
    final borderSize = Device.get().isTablet ? 12.0 : 6.0;

    if (kana.status.isSelect) {
      return KanaViewerSelectRomaji(romaji: kana.romaji, size: squareSize, borderSize: borderSize);
    }
    if (kana.status.isNormal) {
      return _KanaViewerRomaji(romaji: kana.romaji, size: squareSize, borderSize: borderSize);
    }
    if (kana.status.isCorrect || kana.status.isWrong) {
      return _KanaViewerKana(
        size: squareSize,
        borderSize: borderSize,
        strokes: kana.strokes,
        userStrokes: kana.userStrokes,
        correct: kana.status.isCorrect,
      );
    }
    return Container();
  }
}

class KanaViewerSelectRomaji extends StatefulWidget {
  const KanaViewerSelectRomaji({
    required this.romaji,
    required this.size,
    required this.borderSize,
    Key? key,
  }) : super(key: key);

  final String romaji;
  final double size;
  final double borderSize;

  @override
  State<KanaViewerSelectRomaji> createState() => _KanaViewerSelectRomajiState();
}

class _KanaViewerSelectRomajiState extends State<KanaViewerSelectRomaji> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
              builder: (context, child) {
                return Transform.scale(
                  scale: 1 + _controller.value * 0.1,
                  child: RomajiViewer(widget.romaji),
                );
              },
            ),
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Container(
                  alignment: Alignment.center,
                  width: widget.size,
                  height: widget.size,
                  color: Colors.transparent,
                ),
              ),
            ),
            CustomPaint(
              painter: BorderPainter(borderSize: widget.borderSize, borderColor: Colors.grey.shade500),
              size: Size.square(widget.size),
            ),
            RomajiViewer(widget.romaji),
          ],
        ),
      ),
    );
  }
}

class _KanaViewerRomaji extends StatelessWidget {
  const _KanaViewerRomaji({
    required this.romaji,
    required this.size,
    required this.borderSize,
    Key? key,
  }) : super(key: key);

  final String romaji;
  final double size;
  final double borderSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            CustomPaint(
              painter: BorderPainter(borderSize: borderSize, borderColor: Colors.grey.shade500),
              size: Size.square(size),
            ),
            RomajiViewer(romaji),
          ],
        ),
      ),
    );
  }
}

class _KanaViewerKana extends StatelessWidget {
  const _KanaViewerKana({
    required this.strokes,
    required this.userStrokes,
    required this.correct,
    required this.size,
    required this.borderSize,
    Key? key,
  })  : squareTapSize = size - borderSize * 2,
        super(key: key);

  final List<String> strokes;
  final List<List<Offset>> userStrokes;
  final bool correct;
  final double size;
  final double borderSize;
  final double squareTapSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            CustomPaint(
              painter: BorderPainter(borderSize: borderSize, borderColor: correct ? Colors.blueAccent : Colors.redAccent),
              size: Size.square(size),
            ),
            Positioned(
              top: borderSize,
              left: borderSize,
              child: CustomPaint(
                painter: KanaPainter(borderSize: borderSize, strokes: strokes, strokeWidth: 6),
                size: Size.square(squareTapSize),
              ),
            ),
            Positioned(
              top: borderSize,
              left: borderSize,
              child: CustomPaint(
                painter: UserKanaPainter(strokes: userStrokes, strokeWidth: 6),
                size: Size.square(squareTapSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
