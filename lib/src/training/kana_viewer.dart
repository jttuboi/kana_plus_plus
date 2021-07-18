import 'dart:ui';

import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/shared/images.dart';
import 'package:kana_plus_plus/src/training/kana_viewer_status.dart';

class KanaViewer extends StatefulWidget {
  const KanaViewer({
    Key? key,
    required this.status,
    required this.romaji,
    required this.kana,
    this.userKana,
  }) : super(key: key);

  final KanaViewerStatus status;
  final Image romaji;
  final Image kana;
  final Image? userKana;

  @override
  _KanaViewerState createState() => _KanaViewerState();
}

class _KanaViewerState extends State<KanaViewer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    if (widget.status.isShowSelected) {
      _controller.repeat(reverse: true);
    } else if (_controller.isAnimating) {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.status.isShowSelected) ..._buildRomajiEffect(),
        JImages.square,
        if (widget.status.isShowSelected || widget.status.isShowInitial)
          widget.romaji
        else ...[widget.kana, widget.userKana!],
        if (widget.status.isShowCorrect) JImages.correct,
        if (widget.status.isShowWrong) JImages.wrong,
      ],
    );
  }

  List<Widget> _buildRomajiEffect() {
    return [
      AnimatedBuilder(
        animation: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        builder: (context, child) {
          return Transform.scale(
            scale: 1 + _controller.value * 0.1,
            child: widget.romaji,
          );
        },
      ),
      LayoutBuilder(
        builder: (context, constraints) {
          return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
              child: Container(
                alignment: Alignment.center,
                width: constraints.maxHeight,
                height: constraints.maxHeight,
                color: Colors.black.withOpacity(0.0),
              ),
            ),
          );
        },
      ),
    ];
  }
}
