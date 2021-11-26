part of 'kana_bloc.dart';

abstract class KanaEvent extends Equatable {
  const KanaEvent();

  @override
  List<Object> get props => [];
}

class KanaUpdated extends KanaEvent {
  const KanaUpdated({
    this.kanaIndex = 0,
    this.kanas = const <KanaViewModel>[],
  });

  final int kanaIndex;
  final List<KanaViewModel> kanas;

  @override
  List<Object> get props => [kanaIndex, kanas];
}
