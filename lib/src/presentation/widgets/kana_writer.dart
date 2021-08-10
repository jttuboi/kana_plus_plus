import 'dart:ui';
import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';
import 'package:kana_plus_plus/src/presentation/state_management/all_stroke.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/current_stroke.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/kana_writer.state_management.dart';
import 'package:provider/provider.dart';

class KanaWriter extends StatelessWidget {
  KanaWriter({
    Key? key,
    required this.stateManagement,
    required this.writerController,
    required this.onKanaRecovered,
  }) : super(key: key);

  final WriterStateManagement stateManagement;
  final WriterController writerController;
  final Function(List<List<Offset>> strokes, int kanaIdWrote) onKanaRecovered;

  final GlobalKey gestureKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AllStrokesProvider(writerController)),
        ChangeNotifierProvider(create: (context) => CurrentStrokeProvider()),
      ],
      child: stateManagement.isWritingHandRight ? _buildRightHand() : _buildLeftHand(),
    );
  }

  Widget _buildRightHand() {
    return Row(
      children: [
        _buildSupportButtons(),
        const SizedBox(width: 4),
        _buildKanaDraw(),
      ],
    );
  }

  Widget _buildLeftHand() {
    return Row(
      children: [
        _buildKanaDraw(),
        const SizedBox(width: 4),
        _buildSupportButtons(),
      ],
    );
  }

  Widget _buildSupportButtons() {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: AnimatedBuilder(
            animation: stateManagement,
            builder: (context, child) {
              return ElevatedButton(
                onPressed: stateManagement.isDisabled ? null : () => _clearStrokes(context),
                child: ImageIcon(AssetImage(stateManagement.eraserIconUrl)),
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        Flexible(
          fit: FlexFit.tight,
          child: AnimatedBuilder(
            animation: stateManagement,
            builder: (context, child) {
              return ElevatedButton(
                onPressed: stateManagement.isDisabled ? null : () => _undoStroke(context),
                child: ImageIcon(AssetImage(stateManagement.undoIconUrl)),
              );
            },
          ),
        ),
      ],
    );
  }

  void _clearStrokes(BuildContext context) {
    final allProvider = Provider.of<AllStrokesProvider>(context, listen: false);
    allProvider.clearStrokes();
  }

  void _undoStroke(BuildContext context) {
    final allProvider = Provider.of<AllStrokesProvider>(context, listen: false);
    allProvider.undoTheLastStroke();
  }

  Widget _buildKanaDraw() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(stateManagement.squareImageUrl, fit: BoxFit.fill),
            if (stateManagement.isShowHint)
              AnimatedBuilder(
                animation: stateManagement,
                builder: (context, child) => Image.asset(stateManagement.kanaHintImageUrl, fit: BoxFit.fill),
              ),
            AnimatedBuilder(
              animation: stateManagement,
              builder: (context, child) => _buildAllStrokes(),
            ),
            _buildCurrentStroke(),
          ],
        ),
      ),
    );
  }

  Widget _buildAllStrokes() {
    return Consumer<AllStrokesProvider>(
      builder: (context, provider, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: CustomPaint(isComplex: true, painter: _AllStrokesPainter(provider.strokes)),
            )
          ],
        );
      },
    );
  }

  Widget _buildCurrentStroke() {
    return Consumer<CurrentStrokeProvider>(
      builder: (context, provider, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            RepaintBoundary(
              child: CustomPaint(isComplex: true, painter: _CurrentStrokePainter(provider.points)),
            ),
            AnimatedBuilder(
              animation: stateManagement,
              builder: (context, child) {
                return GestureDetector(
                  key: gestureKey,
                  onPanStart: stateManagement.isDisabled ? null : (details) => _startStroke(details, context),
                  onPanUpdate: stateManagement.isDisabled ? null : (details) => _updateStroke(details, context),
                  onPanEnd: stateManagement.isDisabled ? null : (details) => _finishStroke(context),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _startStroke(DragStartDetails details, BuildContext context) {
    final provider = Provider.of<CurrentStrokeProvider>(context, listen: false);
    provider.setLimit(0, 0, context.size!.width, context.size!.height);
    provider.addPoint(details.localPosition);
  }

  void _updateStroke(DragUpdateDetails details, BuildContext context) {
    final provider = Provider.of<CurrentStrokeProvider>(context, listen: false);
    provider.addPoint(details.localPosition);
  }

  void _finishStroke(BuildContext context) {
    final provider = Provider.of<CurrentStrokeProvider>(context, listen: false);
    final allProvider = Provider.of<AllStrokesProvider>(context, listen: false);
    allProvider.addStroke(provider.points);
    provider.resetPoints();
    if (stateManagement.isTheLastStroke) {
      onKanaRecovered(
        stateManagement.strokesNormalized(0.0, gestureKey.currentContext!.size!.width),
        stateManagement.generateKanaId,
      );
    }
  }
}

class _AllStrokesPainter extends CustomPainter {
  const _AllStrokesPainter(this.strokes);

  final List<List<Offset>> strokes;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 16.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.black.withOpacity(0.9);

    for (final points in strokes) {
      canvas.drawPoints(PointMode.polygon, points, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _CurrentStrokePainter extends CustomPainter {
  const _CurrentStrokePainter(this.points);

  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 18.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = Colors.black.withOpacity(0.9);

    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
