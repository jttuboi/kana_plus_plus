part of 'writer_bloc.dart';

abstract class WriterEvent extends Equatable {
  const WriterEvent();

  @override
  List<Object> get props => [];
}

class WriterStarted extends WriterEvent {
  const WriterStarted({
    required this.kanaId,
    required this.strokesForDraw,
  });

  final String kanaId;
  final List<String> strokesForDraw;

  @override
  List<Object> get props => [kanaId, strokesForDraw];
}

class StrokeWritten extends WriterEvent {
  const StrokeWritten(this.stroke, this.maxSize);

  final List<Offset> stroke;
  final double maxSize;

  @override
  List<Object> get props => [stroke, maxSize];
}

class WriterReseted extends WriterEvent {
  const WriterReseted();
}
