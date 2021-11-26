part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

class ListStarted extends ListEvent {
  const ListStarted(this.trainingSettings);

  final TrainingSettings trainingSettings;

  @override
  List<Object> get props => [trainingSettings];
}

class ListWordUpdated extends ListEvent {
  const ListWordUpdated({
    this.wordIndex = 0,
    this.kanaIndex = 0,
    this.words = const <WordViewModel>[],
  });

  final int wordIndex;
  final int kanaIndex;
  final List<WordViewModel> words;

  @override
  List<Object> get props => [wordIndex, kanaIndex, words];
}

class ListKanaUpdated extends ListEvent {
  const ListKanaUpdated({
    this.wordIndex = 0,
    this.kanaIndex = 0,
    this.words = const <WordViewModel>[],
  });

  final int wordIndex;
  final int kanaIndex;
  final List<WordViewModel> words;

  @override
  List<Object> get props => [wordIndex, kanaIndex, words];
}

class ListClosed extends ListEvent {
  const ListClosed(this.words);

  final List<WordViewModel> words;

  @override
  List<Object> get props => [words];
}
