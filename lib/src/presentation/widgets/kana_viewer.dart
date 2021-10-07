import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/src/domain/entities/kana_viewer_content.dart';
import 'package:kwriting/src/domain/utils/kana_viewer_status.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/widgets/border_painter.dart';
import 'package:kwriting/src/presentation/widgets/user_kana_viewer.dart';

class KanaViewer extends StatefulWidget {
  const KanaViewer(this.content, {Key? key, required this.size}) : super(key: key);

  final double size;
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
    final size = Size(widget.size, widget.size);
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          children: [
            if (widget.content.status.isShowSelected) ..._buildRomajiEffect(),
            CustomPaint(
              painter: BorderPainter(
                  borderWidth: kanaViewerBorderWidth,
                  borderColor: (widget.content.status.isShowCorrect)
                      ? correctBorderColor
                      : (widget.content.status.isShowWrong)
                          ? wrongBorderColor
                          : defaultBorderColor),
              size: size,
            ),
            if (widget.content.status.isShowSelected || widget.content.status.isShowInitial)
              RomajiViewer(widget.content.romaji)
            else ...[
              SvgPicture.asset(widget.content.kanaImageUrl, width: size.width, height: size.height),
              Center(
                child: SizedBox(
                  width: size.width - 8.0,
                  height: size.height - 8.0,
                  child: UserKanaViewer(strokes: widget.content.strokesDrew, size: size),
                ),
              ),
            ],
          ],
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
            child: RomajiViewer(widget.content.romaji),
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
    ];
  }
}

class RomajiViewer extends StatelessWidget {
  const RomajiViewer(this.romaji, {Key? key}) : super(key: key);

  final String romaji;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(romaji, style: romajiVieverTextStyle),
    );
  }
}
