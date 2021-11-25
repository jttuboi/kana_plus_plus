part of 'filtered_words_bloc.dart';

abstract class FilteredWordsEvent extends Equatable {
  const FilteredWordsEvent();

  @override
  List<Object> get props => [];
}

class FilterUpdated extends FilteredWordsEvent {
  const FilterUpdated(this.filter, this.query);

  final Filter filter;
  final String query;

  @override
  List<Object> get props => [filter, query];
  @override
  String toString() => 'FilterUpdated($filter, $query)';
}

class WordsUpdated extends FilteredWordsEvent {
  const WordsUpdated(this.words);

  final List<WordViewModel> words;

  @override
  List<Object> get props => [words];
  @override
  String toString() => 'WordsUpdated($words)';
}
