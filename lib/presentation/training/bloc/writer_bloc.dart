import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';

part 'writer_event.dart';
part 'writer_state.dart';

class WriterBloc extends Bloc<WriterEvent, WriterState> {
  WriterBloc({required StrokeReducer strokeReducer, required KanaChecker kanaChecker})
      : _strokeReducer = strokeReducer,
        _kanaChecker = kanaChecker,
        super(const WriterInitial()) {
    on<WriterStarted>(_onWriterStarted);
    on<StrokeWritten>(_onStrokeWritten);

    _initKanaChecker();
  }

  late final StrokeReducer _strokeReducer;
  late final KanaChecker _kanaChecker;

  Future<void> _onWriterStarted(WriterStarted event, Emitter<WriterState> emit) async {
    emit(WriterWait(
      kanaId: event.kanaId,
      strokesQuantity: event.strokesQuantity,
      strokesForDraw: event.strokesForDraw,
    ));
  }

  Future<void> _onStrokeWritten(StrokeWritten event, Emitter<WriterState> emit) async {
    final oldState = state as WriterWait;
    final pointsReduced = _strokeReducer.reduce(event.stroke);
    final pointsNormalized = pointsReduced.toNormalizedList(0, event.maxSize);
    final correct = _kanaChecker.checkKana(oldState.kanaId, state.userStrokes.length, pointsNormalized);

    if (oldState.isLastStroke) {
      emit(WriterEnd(
        kanaId: oldState.kanaId,
        strokesQuantity: oldState.strokesQuantity,
        strokesForDraw: oldState.strokesForDraw,
        userStrokes: List.from(oldState.userStrokes)..add(pointsReduced),
        corrects: List.from(oldState.corrects)..add(correct),
      ));
    } else {
      emit(oldState.copyWith(
        currentIndexStroke: oldState.currentIndexStroke + 1,
        userStrokes: List.from(oldState.userStrokes)..add(pointsReduced),
        corrects: List.from(oldState.corrects)..add(correct),
      ));
    }
  }

  Future<void> _initKanaChecker() async {
    await _kanaChecker.initialize();
  }
}

extension ListOffsetExtension on List<Offset> {
  List<Offset> toNormalizedList(double startCanvasLimit, double endCanvasLimit) {
    return map((point) => Offset(
          (point.dx - startCanvasLimit) / (endCanvasLimit - startCanvasLimit),
          (point.dy - startCanvasLimit) / (endCanvasLimit - startCanvasLimit),
        )).toList();
  }
}
