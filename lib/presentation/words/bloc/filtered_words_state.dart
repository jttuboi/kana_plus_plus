part of 'filtered_words_bloc.dart';

abstract class FilteredWordsState extends Equatable {
  const FilteredWordsState();

  @override
  List<Object> get props => [];
}

class FilteredWordsLoadInProgress extends FilteredWordsState {
  const FilteredWordsLoadInProgress();

  @override
  String toString() => 'FilteredWordsLoadInProgress()';
}

class FilteredWordsLoadSuccess extends FilteredWordsState {
  const FilteredWordsLoadSuccess({
    required this.filteredWords,
    required this.currentFilter,
  });

  final List<Word> filteredWords;
  final Filter currentFilter;

  @override
  List<Object> get props => [filteredWords, currentFilter];

  @override
  String toString() => 'FilteredWordsLoadSuccess($filteredWords, $currentFilter)';
}
