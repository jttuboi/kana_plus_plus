part of 'word_bloc.dart';

abstract class WordEvent extends Equatable {
  const WordEvent();

  @override
  List<Object> get props => [];
}

class WordUpdated extends WordEvent {
  const WordUpdated({
    this.wordIndex = 0,
    this.words = const <WordViewModel>[],
  });

  final int wordIndex;
  final List<WordViewModel> words;

  @override
  List<Object> get props => [wordIndex, words];
}
