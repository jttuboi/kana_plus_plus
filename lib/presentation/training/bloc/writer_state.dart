part of 'writer_bloc.dart';

abstract class WriterState extends Equatable {
  const WriterState(
    this.strokesForDraw,
    this.userStrokes,
    this.corrects,
  );

  final List<String> strokesForDraw;
  final List<List<Offset>> userStrokes;
  final List<bool> corrects;

  @override
  List<Object> get props => [strokesForDraw, userStrokes, corrects];
}

class WriterInitial extends WriterState {
  const WriterInitial() : super(const <String>[], const <List<Offset>>[], const <bool>[]);
}

class WriterWait extends WriterState {
  const WriterWait({
    this.kanaId = '',
    this.currentIndexStroke = 0,
    List<String> strokesForDraw = const <String>[],
    List<List<Offset>> userStrokes = const <List<Offset>>[],
    List<bool> corrects = const <bool>[],
  }) : super(strokesForDraw, userStrokes, corrects);

  final String kanaId;
  final int currentIndexStroke;

  @override
  List<Object> get props => [kanaId, strokesForDraw, currentIndexStroke, userStrokes, corrects];

  WriterWait copyWith({
    int? currentIndexStroke,
    List<List<Offset>>? userStrokes,
    List<bool>? corrects,
  }) {
    return WriterWait(
      kanaId: kanaId,
      strokesForDraw: strokesForDraw,
      currentIndexStroke: currentIndexStroke ?? this.currentIndexStroke,
      userStrokes: userStrokes ?? this.userStrokes,
      corrects: corrects ?? this.corrects,
    );
  }

  bool get isLastStroke => currentIndexStroke >= strokesForDraw.length - 1;
}

class WriterEnd extends WriterState {
  const WriterEnd({
    required this.kanaId,
    required List<String> strokesForDraw,
    required List<List<Offset>> userStrokes,
    required List<bool> corrects,
  }) : super(strokesForDraw, userStrokes, corrects);

  final String kanaId;

  @override
  List<Object> get props => [kanaId, strokesForDraw, userStrokes, corrects];
}
