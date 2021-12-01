part of 'kana_bloc.dart';

abstract class KanaState extends Equatable {
  const KanaState();

  @override
  List<Object> get props => [];
}

class KanaInitial extends KanaState {
  const KanaInitial();
}

class KanaReady extends KanaState {
  const KanaReady({
    this.index = 0,
    this.total = 0,
    this.kanas = const <KanaViewModel>[],
  });

  final int index;
  final int total;
  final List<KanaViewModel> kanas;

  @override
  List<Object> get props => [index, total, kanas];
}
