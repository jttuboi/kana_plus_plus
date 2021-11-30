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

class ListUpdated extends ListEvent {
  const ListUpdated({
    required this.wordIndex,
    required this.kanaIndex,
    required this.words,
  });

  final int wordIndex;
  final int kanaIndex;
  final List<WordViewModel> words;

  @override
  List<Object> get props => [wordIndex, kanaIndex, words];
}

class ListPreUpdated extends ListUpdated {
  const ListPreUpdated({
    int wordIndex = 0,
    int kanaIndex = 0,
    List<WordViewModel> words = const <WordViewModel>[],
  }) : super(wordIndex: wordIndex, kanaIndex: kanaIndex, words: words);
}

class ListKanaChanged extends ListUpdated {
  const ListKanaChanged({
    int wordIndex = 0,
    int kanaIndex = 0,
    List<WordViewModel> words = const <WordViewModel>[],
  }) : super(wordIndex: wordIndex, kanaIndex: kanaIndex, words: words);
}

class ListWordChanged extends ListUpdated {
  const ListWordChanged({
    int wordIndex = 0,
    List<WordViewModel> words = const <WordViewModel>[],
  }) : super(wordIndex: wordIndex, kanaIndex: 0, words: words);
}

class ListPageAnimationChanged extends ListUpdated {
  const ListPageAnimationChanged({
    required this.changePageDurationInMilliseconds,
    int wordIndex = 0,
    int kanaIndex = 0,
    List<WordViewModel> words = const <WordViewModel>[],
  }) : super(wordIndex: wordIndex, kanaIndex: kanaIndex, words: words);
  final int changePageDurationInMilliseconds;
}

class ListTrainingEnded extends ListEvent {
  const ListTrainingEnded(this.words);

  final List<WordViewModel> words;

  @override
  List<Object> get props => [words];
}
