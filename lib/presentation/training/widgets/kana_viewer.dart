import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

class KanaViewer extends StatelessWidget {
  const KanaViewer(this.kana, {required this.squareSize, Key? key}) : super(key: key);

  final double squareSize;
  final KanaViewModel kana;

  @override
  Widget build(BuildContext context) {
    if (kana.status.isSelect) {
      return KanaViewerSelectRomaji(romaji: kana.romaji, squareSize: squareSize);
    }
    if (kana.status.isNormal) {
      return _KanaViewerRomaji(romaji: kana.romaji, squareSize: squareSize);
    }
    if (kana.status.isCorrect || kana.status.isWrong) {
      return _KanaViewerKana(
        imageUrl: kana.imageUrl,
        squareSize: squareSize,
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
    required this.squareSize,
    Key? key,
  }) : super(key: key);

  final String romaji;
  final double squareSize;

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
                  width: widget.squareSize,
                  height: widget.squareSize,
                  color: Colors.transparent,
                ),
              ),
            ),
            CustomPaint(
              size: Size.square(widget.squareSize),
              painter: BorderPainter(
                borderWidth: Device.get().isTablet ? 8 : 4,
                borderColor: Colors.grey.shade500,
              ),
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
    required this.squareSize,
    Key? key,
  }) : super(key: key);

  final String romaji;
  final double squareSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            CustomPaint(
              painter: BorderPainter(
                borderWidth: Device.get().isTablet ? 8 : 4,
                borderColor: Colors.grey.shade500,
              ),
              size: Size.square(squareSize),
            ),
            RomajiViewer(romaji)
          ],
        ),
      ),
    );
  }
}

class _KanaViewerKana extends StatelessWidget {
  const _KanaViewerKana({
    required this.imageUrl,
    required this.squareSize,
    required this.userStrokes,
    required this.correct,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final double squareSize;
  final List<List<Offset>> userStrokes;
  final bool correct;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            CustomPaint(
              painter: BorderPainter(
                borderWidth: Device.get().isTablet ? 8 : 4,
                borderColor: correct ? Colors.blueAccent : Colors.redAccent,
              ),
              size: Size.square(squareSize),
            ),
            SvgPicture.asset(imageUrl, width: squareSize, height: squareSize),
            Center(
              child: SizedBox(
                width: squareSize - 8,
                height: squareSize - 8,
                child: UserKanaViewer(userStrokes: userStrokes, size: Size.square(squareSize)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
