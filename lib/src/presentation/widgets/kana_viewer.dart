import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/presentation/widgets/border_painter.dart';
import 'package:kana_plus_plus/src/presentation/widgets/user_kana_viewer.dart';

class KanaViewer extends StatefulWidget {
  const KanaViewer(this.content, {Key? key}) : super(key: key);

  final KanaViewerContent content;

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
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final size = Size(constraints.maxWidth, constraints.maxHeight);

            return Stack(
              children: [
                if (widget.content.status.isShowSelected) ..._buildRomajiEffect(),
                CustomPaint(painter: BorderPainter(), size: size),
                if (widget.content.status.isShowSelected || widget.content.status.isShowInitial)
                  Image.asset(widget.content.romajiImageUrl)
                else ...[
                  SvgPicture.asset(widget.content.kanaImageUrl),
                  UserKanaViewer(strokes: widget.content.strokesDrew, size: size),
                ],
                if (widget.content.status.isShowCorrect) Image.asset(ImageUrl.correct),
                if (widget.content.status.isShowWrong) Image.asset(ImageUrl.wrong),
              ],
            );
          },
        ),
      ),
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
