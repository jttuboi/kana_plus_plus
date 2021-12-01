part of 'list_bloc.dart';

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

class ListInitial extends ListState {}

class ListReady extends ListState {
  const ListReady({
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

class ListPreReady extends ListReady {
  const ListPreReady({
    int wordIndex = 0,
    int kanaIndex = 0,
    List<WordViewModel> words = const <WordViewModel>[],
  }) : super(wordIndex: wordIndex, kanaIndex: kanaIndex, words: words);
}

class ListKanaReady extends ListReady {
  const ListKanaReady({
    int wordIndex = 0,
    int kanaIndex = 0,
    List<WordViewModel> words = const <WordViewModel>[],
  }) : super(wordIndex: wordIndex, kanaIndex: kanaIndex, words: words);
}

class ListWordReady extends ListReady {
  const ListWordReady({
    int wordIndex = 0,
    int kanaIndex = 0,
    List<WordViewModel> words = const <WordViewModel>[],
  }) : super(wordIndex: wordIndex, kanaIndex: kanaIndex, words: words);
}

class ListPageReady extends ListReady {
  const ListPageReady({
    required this.changePageDurationInMilliseconds,
    int wordIndex = 0,
    int kanaIndex = 0,
    List<WordViewModel> words = const <WordViewModel>[],
  }) : super(wordIndex: wordIndex, kanaIndex: kanaIndex, words: words);
  final int changePageDurationInMilliseconds;
}

class TrainingEnded extends ListState {
  const TrainingEnded({
    this.words = const <WordViewModel>[],
  });

  final List<WordViewModel> words;

  @override
  List<Object> get props => [words];
}
