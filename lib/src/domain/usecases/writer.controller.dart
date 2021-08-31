import 'dart:ui';
import 'package:kana_plus_plus/src/domain/entities/kana_to_writer.dart';
import 'package:kana_plus_plus/src/domain/enums/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/repositories/writing_hand.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/services/kana_checker.interface.service.dart';
import 'package:kana_plus_plus/src/domain/services/stroke_reducer.interface.service.dart';

class WriterController {
  WriterController({
    required this.writingHandRepository,
    required this.strokeReducerService,
    required this.kanaCheckerService,
    required this.showHint,
  });

  IWritingHandRepository writingHandRepository;

  late final IStrokeReducerService strokeReducerService;
  late final IKanaCheckerService kanaCheckerService;

  bool showHint;

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
    strokes.add(strokeReducerService.reduce(stroke));
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
    final isOk = kanaCheckerService.checkKana(kanaToWrite.id, normalizedStrokes);
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
