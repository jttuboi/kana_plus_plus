import 'dart:ui';
import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/presentation/widgets/user_kana_viewer.dart';

class KanaViewer extends StatefulWidget {
  const KanaViewer(
    this.content, {
    Key? key,
    required this.squareImageUrl,
    required this.correctImageUrl,
    required this.wrongImageUrl,
  }) : super(key: key);

  final KanaViewerContent content;
  final String squareImageUrl;
  final String correctImageUrl;
  final String wrongImageUrl;

  @override
  _KanaViewerState createState() => _KanaViewerState();
}

class _KanaViewerState extends State<KanaViewer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    if (widget.content.status.isShowSelected) {
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
        if (widget.content.status.isShowSelected) ..._buildRomajiEffect(),
        Image.asset(widget.squareImageUrl),
        if (widget.content.status.isShowSelected || widget.content.status.isShowInitial)
          Image.asset(widget.content.romajiImageUrl)
        else ...[
          Image.asset(widget.content.kanaImageUrl),
          LayoutBuilder(builder: (context, constraints) {
            // 80.0 is an random number. I don't know how to decide this. I only know the witdh and height is based of KanaViewers,
            // in other words, width is infinite and height has a limit size.
            final size = !constraints.hasInfiniteHeight ? constraints.maxHeight : (!constraints.hasInfiniteWidth ? constraints.maxWidth : 80.0);
            return UserKanaViewer(strokes: widget.content.strokesDrew, size: Size(size, size));
          })
        ],
        if (widget.content.status.isShowCorrect) Image.asset(widget.correctImageUrl),
        if (widget.content.status.isShowWrong) Image.asset(widget.wrongImageUrl),
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
            child: Image.asset(widget.content.romajiImageUrl),
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
