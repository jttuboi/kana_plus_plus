import 'dart:ui';
import 'package:kwriting/src/domain/entities/kana_to_writer.dart';
import 'package:kwriting/src/domain/repositories/writing_hand.interface.repository.dart';
import 'package:kwriting/src/domain/support/kana_checker.dart';
import 'package:kwriting/src/domain/support/stroke_reducer.dart';
import 'package:kwriting/src/domain/utils/writing_hand.dart';

class WriterController {
  WriterController({
    required this.writingHandRepository,
    required this.strokeReducer,
    required this.kanaChecker,
    required this.showHint,
  });

  final IWritingHandRepository writingHandRepository;
  final StrokeReducer strokeReducer;
  final IKanaChecker kanaChecker;

  final bool showHint;

  List<List<Offset>> strokes = [];
  late KanaToWrite kanaToWrite;

  double _startCanvasLimit = 0.0;
  double _endCanvasLimit = 100.0;

  bool get isWritingHandRight => writingHandRepository.getWritingHandSelected().isRight;

  String get kanaHintImageUrl => kanaToWrite.hintImageUrl;

  bool get isTheLastStroke => strokes.length >= kanaToWrite.maxStrokes;

  void updateWriter(KanaToWrite pKanaToWrite) {
    strokes.clear();
    kanaToWrite = pKanaToWrite;
  }

  void setCanvasLimit(double minCanvasLimit, double maxCanvasLimit) {
    _startCanvasLimit = minCanvasLimit;
    _endCanvasLimit = maxCanvasLimit;
  }

  void addStroke(List<Offset> stroke) {
    if (stroke.length > 3) {
      strokes.add(strokeReducer.reduce(stroke));
    }
  }

  void clearStrokes() {
    strokes.clear();
  }

  void undoTheLastStroke() {
    if (strokes.isNotEmpty) {
      strokes.removeLast();
    }
  }

  String get kanaWrote {
    //print('kanaWrote -> kanaToWrite = $kanaToWrite');
    final isOk = kanaChecker.checkKana(kanaToWrite.id, normalizedStrokes);
    return isOk ? kanaToWrite.id : '';
  }

  List<List<Offset>> get normalizedStrokes {
    final strokesNormalized = <List<Offset>>[];
    for (final stroke in strokes) {
      final strokeNormalized = <Offset>[];
      for (final point in stroke) {
        final pointNormalized = Offset(
          (point.dx - _startCanvasLimit) / (_endCanvasLimit - _startCanvasLimit),
          (point.dy - _startCanvasLimit) / (_endCanvasLimit - _startCanvasLimit),
        );
        strokeNormalized.add(pointNormalized);
      }
      strokesNormalized.add(strokeNormalized);
    }
    return strokesNormalized;
  }
}
