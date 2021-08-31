import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';
import 'package:kana_plus_plus/src/presentation/state_management/all_stroke.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/current_stroke.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/writer.provider.dart';
import 'package:kana_plus_plus/src/presentation/widgets/border_painter.dart';
import 'package:provider/provider.dart';

class Writer extends StatelessWidget {
  const Writer({
    Key? key,
    required this.writerController,
    required this.onKanaRecovered,
  }) : super(key: key);

  final WriterController writerController;
  final Function(List<List<Offset>> strokes, String kanaIdWrote) onKanaRecovered;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AllStrokesProvider(writerController)),
        ChangeNotifierProvider(create: (context) => CurrentStrokeProvider(writerController)),
      ],
      child: writerController.isWritingHandRight ? _buildRightHand() : _buildLeftHand(),
    );
  }

  Widget _buildRightHand() {
    return Row(
      children: [
        const _SupportButtons(),
        const SizedBox(width: 4),
        _buildDrawer(),
      ],
    );
  }

  Widget _buildLeftHand() {
    return Row(
      children: [
        _buildDrawer(),
        const SizedBox(width: 4),
        const _SupportButtons(),
      ],
    );
  }

  Widget _buildDrawer() {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: _Drawer(writerController: writerController, onKanaRecovered: onKanaRecovered),
      ),
    );
  }
}

class _SupportButtons extends StatelessWidget {
  const _SupportButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: Consumer<WriterProvider>(
            builder: (context, provider, child) {
              return ElevatedButton(
                onPressed: provider.isDisabled ? null : () => _clearStrokes(context),
                child: const ImageIcon(AssetImage(IconUrl.eraser)),
              );
            },
          ),
        ),
        const SizedBox(height: 4),
        Flexible(
          fit: FlexFit.tight,
          child: Consumer<WriterProvider>(
            builder: (context, provider, child) {
              return ElevatedButton(
                onPressed: provider.isDisabled ? null : () => _undoStroke(context),
                child: const ImageIcon(AssetImage(IconUrl.undo)),
              );
            },
          ),
        ),
      ],
    );
  }

  void _clearStrokes(BuildContext context) {
    final allStrokesProvider = Provider.of<AllStrokesProvider>(context, listen: false);
    allStrokesProvider.clearStrokes();
  }

  void _undoStroke(BuildContext context) {
    final allStrokesProvider = Provider.of<AllStrokesProvider>(context, listen: false);
    allStrokesProvider.undoTheLastStroke();
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    Key? key,
    required this.writerController,
    required this.onKanaRecovered,
  }) : super(key: key);

  final WriterController writerController;
  final Function(List<List<Offset>> strokes, String kanaIdWrote) onKanaRecovered;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth;

        final currentStrokeProvider = Provider.of<CurrentStrokeProvider>(context, listen: false);
        currentStrokeProvider.setCanvasLimit(0, size);

        return Stack(
          children: [
            Container(color: Colors.grey[200], height: size, width: size),
            CustomPaint(painter: BorderPainter(), size: Size.square(size)),
            Consumer<WriterProvider>(
              builder: (context, provider, child) {
                return (writerController.showHint)
                    ? Image.asset(writerController.kanaHintImageUrl, height: size, width: size, fit: BoxFit.cover)
                    : Container();
              },
            ),
            SizedBox(
              height: size,
              width: size,
              child: Consumer<AllStrokesProvider>(
                builder: (context, provider, child) {
                  return RepaintBoundary(
                    child: CustomPaint(isComplex: true, painter: _AllStrokesPainter(provider.strokes)),
                  );
                },
              ),
            ),
            SizedBox(
              height: size,
              width: size,
              child: Consumer<WriterProvider>(
                builder: (context, writerProvider, child) {
                  return GestureDetector(
                    onPanStart: writerProvider.isDisabled ? null : (details) => _startStroke(details, context, size),
                    onPanUpdate: writerProvider.isDisabled ? null : (details) => _updateStroke(details, context),
                    onPanEnd: writerProvider.isDisabled ? null : (details) => _finishStroke(context),
                    child: Consumer<CurrentStrokeProvider>(
                      builder: (context, provider, child) {
                        return RepaintBoundary(
                          child: CustomPaint(isComplex: true, painter: _CurrentStrokePainter(provider.points)),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _startStroke(DragStartDetails details, BuildContext context, double size) {
    final currentStrokeProvider = Provider.of<CurrentStrokeProvider>(context, listen: false);
    currentStrokeProvider.addPoint(details.localPosition);
  }

  void _updateStroke(DragUpdateDetails details, BuildContext context) {
    final currentStrokeProvider = Provider.of<CurrentStrokeProvider>(context, listen: false);
    currentStrokeProvider.addPoint(details.localPosition);
  }

  void _finishStroke(BuildContext context) {
    final currentStrokeProvider = Provider.of<CurrentStrokeProvider>(context, listen: false);
    final allStrokesProvider = Provider.of<AllStrokesProvider>(context, listen: false);
    allStrokesProvider.addStroke(currentStrokeProvider.points);
    currentStrokeProvider.resetPoints();
    if (writerController.isTheLastStroke) {
      onKanaRecovered(writerController.normalizedStrokes, writerController.kanaWrote);
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
      ..color = Colors.black;

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
