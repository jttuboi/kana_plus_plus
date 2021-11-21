part of 'words_bloc.dart';

abstract class WordsState extends Equatable {
  const WordsState();

  @override
  List<Object> get props => [];
}

class WordsLoadSuccess extends WordsState {
  const WordsLoadSuccess([this.words = const []]);

  final List<Word> words;

  @override
  List<Object> get props => [words];

  @override
  String toString() => 'WordsLoadSuccess($words)';
}

class WordsLoadInProgress extends WordsState {
  @override
  String toString() => 'WordsLoadInProgress()';
}

class WordsLoadFailure extends WordsState {
  @override
  String toString() => 'WordsLoadFailure()';
}
