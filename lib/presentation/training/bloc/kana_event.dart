part of 'kana_bloc.dart';

abstract class KanaEvent extends Equatable {
  const KanaEvent();

  @override
  List<Object> get props => [];
}

class KanaUpdated extends KanaEvent {
  const KanaUpdated({
    this.kanaIndex = 0,
    this.wordIndex = 0,
    this.words = const <WordViewModel>[],
  });

  final int kanaIndex;
  final int wordIndex;
  final List<WordViewModel> words;

  @override
  List<Object> get props => [kanaIndex, wordIndex, words];
}

class KanaPageChanged extends KanaEvent {
  const KanaPageChanged({
    this.wordIndex = 0,
    this.words = const <WordViewModel>[],
  });

  final int wordIndex;
  final List<WordViewModel> words;

  @override
  List<Object> get props => [wordIndex, words];
}
