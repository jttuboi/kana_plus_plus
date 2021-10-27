import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/src/infrastructure/datasources/icon_url.storage.dart';
import 'package:kwriting/training/domain/use_cases/writer.controller.dart';
import 'package:kwriting/training/presentation/notifiers/all_stroke.change_notifier.dart';
import 'package:kwriting/training/presentation/notifiers/current_stroke.change_notifier.dart';
import 'package:kwriting/training/presentation/notifiers/writer.change_notifier.dart';
import 'package:kwriting/training/presentation/widgets/border_painter.dart';
import 'package:provider/provider.dart';

class Writer extends StatelessWidget {
  const Writer({
    required this.width,
    required this.height,
    required this.writerController,
    required this.onKanaRecovered,
    Key? key,
  }) : super(key: key);

  final double width;
  final double height;
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
    final widths = getWidths();
    return Row(
      children: [
        _SupportButtons(width: widths['buttonsWidth']!, height: widths['drawerSize']!),
        SizedBox(width: widths['space']),
        _Drawer(drawerSize: widths['drawerSize']!, writerController: writerController, onKanaRecovered: onKanaRecovered),
      ],
    );
  }

  Widget _buildLeftHand() {
    final widths = getWidths();
    return Row(
      children: [
        _Drawer(drawerSize: widths['drawerSize']!, writerController: writerController, onKanaRecovered: onKanaRecovered),
        SizedBox(width: widths['space']),
        _SupportButtons(width: widths['buttonsWidth']!, height: widths['drawerSize']!),
      ],
    );
  }

//   |-------------------w--------------------|
//
//        +-----+   +--------------------+     ---
//        |     |   |                    |      |
//        |  b  |   |                    |      |
//        |     |   |                    |      |
//        +-----+ s |          d         |      h
//        |     |   |                    |      |
//        |  b  |   |                    |      |
//        |     |   |                    |      |
//        +-----+   +--------------------+     ---
//
//        |--x--|-x-|---------4x---------|
//                8
  Map<String, double> getWidths() {
    final theWidthIsGreater = width > height * 41 / 32;
    final x = theWidthIsGreater ? height / 4 : width * 8 / 41;
    return {'buttonsWidth': x, 'space': x / 8, 'drawerSize': 4 * x};
  }
}

class _SupportButtons extends StatelessWidget {
  _SupportButtons({required this.width, required this.height, Key? key}) : super(key: key);

  final writerButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
    overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
    side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.grey, width: Device.get().isTablet ? 2 : 1)),
    animationDuration: const Duration(milliseconds: 50),
    enableFeedback: false,
  );
  final writerIconButtonSize = Device.get().isTablet ? 56.0 : 32.0;
  final writerIconButtonColor = Colors.grey.shade700;

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: height * 2 / 55),
        SizedBox(
          width: width,
          height: height * 25 / 55,
          child: Consumer<WriterProvider>(
            builder: (context, provider, child) {
              return ElevatedButton(
                style: writerButtonStyle,
                onPressed: provider.isDisabled ? null : () => _clearStrokes(context),
                child: SvgPicture.asset(IconUrl.eraser, color: writerIconButtonColor, width: writerIconButtonSize),
              );
            },
          ),
        ),
        SizedBox(height: height * 1 / 55),
        SizedBox(
          width: width,
          height: height * 25 / 55,
          child: Consumer<WriterProvider>(
            builder: (context, provider, child) {
              return ElevatedButton(
                style: writerButtonStyle,
                onPressed: provider.isDisabled ? null : () => _undoStroke(context),
                child: SvgPicture.asset(IconUrl.undo, color: writerIconButtonColor, width: writerIconButtonSize),
              );
            },
          ),
        ),
        SizedBox(height: height * 2 / 55),
      ],
    );
  }

  void _clearStrokes(BuildContext context) {
    Provider.of<AllStrokesProvider>(context, listen: false).clearStrokes();
  }

  void _undoStroke(BuildContext context) {
    Provider.of<AllStrokesProvider>(context, listen: false).undoTheLastStroke();
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({
    required this.drawerSize,
    required this.writerController,
    required this.onKanaRecovered,
    Key? key,
  }) : super(key: key);

  final double drawerSize;
  final WriterController writerController;
  final Function(List<List<Offset>> strokes, String kanaIdWrote) onKanaRecovered;

  @override
  Widget build(BuildContext context) {
    Provider.of<CurrentStrokeProvider>(context, listen: false).setCanvasLimit(16, drawerSize - 16.0);

    return Stack(
      children: [
        CustomPaint(
          painter: BorderPainter(borderWidth: Device.get().isTablet ? 15.0 : 9.0, borderColor: Colors.grey.shade500),
          size: Size.square(drawerSize),
        ),
        Consumer<WriterProvider>(
          builder: (context, provider, child) {
            return (writerController.showHint)
                ? SvgPicture.asset(writerController.kanaHintImageUrl, height: drawerSize, width: drawerSize, fit: BoxFit.cover)
                : Container();
          },
        ),
        SizedBox(
          height: drawerSize,
          width: drawerSize,
          child: Consumer<AllStrokesProvider>(
            builder: (context, provider, child) {
              return RepaintBoundary(
                child: CustomPaint(isComplex: true, painter: _AllStrokesPainter(provider.strokes)),
              );
            },
          ),
        ),
        SizedBox(
          height: drawerSize,
          width: drawerSize,
          child: Consumer<WriterProvider>(
            builder: (context, writerProvider, child) {
              return GestureDetector(
                onPanStart: writerProvider.isDisabled ? null : (details) => _startStroke(details, context, drawerSize),
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
  }

  void _startStroke(DragStartDetails details, BuildContext context, double size) {
    Provider.of<CurrentStrokeProvider>(context, listen: false).addPoint(details.localPosition);
  }

  void _updateStroke(DragUpdateDetails details, BuildContext context) {
    Provider.of<CurrentStrokeProvider>(context, listen: false).addPoint(details.localPosition);
  }

  void _finishStroke(BuildContext context) {
    final currentStrokeProvider = Provider.of<CurrentStrokeProvider>(context, listen: false);
    Provider.of<AllStrokesProvider>(context, listen: false).addStroke(currentStrokeProvider.points);
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
    for (final points in strokes) {
      canvas.drawPoints(
        PointMode.polygon,
        points,
        Paint()
          ..isAntiAlias = true
          ..strokeWidth = Device.get().isTablet ? 22.0 : 14.0
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round
          ..color = Colors.black,
      );
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
    canvas.drawPoints(
      PointMode.polygon,
      points,
      Paint()
        ..isAntiAlias = true
        ..strokeWidth = Device.get().isTablet ? 26.0 : 18.0
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = Colors.black87,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
