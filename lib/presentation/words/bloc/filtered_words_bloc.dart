import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kwriting/presentation/words/words.dart';

part 'filtered_words_event.dart';
part 'filtered_words_state.dart';

class FilteredWordsBloc extends Bloc<FilteredWordsEvent, FilteredWordsState> {
  FilteredWordsBloc({required this.wordsBloc})
      : super(
          (wordsBloc.state is WordsLoadSuccess)
              ? FilteredWordsLoadSuccess(filteredWords: (wordsBloc.state as WordsLoadSuccess).words, currentFilter: Filter.all)
              : const FilteredWordsLoadInProgress(),
        ) {
    on<FilterUpdated>(_onFilterUpdated);
    on<WordsUpdated>(_onWordsUpdated);

    wordsSubscription = wordsBloc.stream.listen((state) {
      if (state is WordsLoadSuccess) {
        add(WordsUpdated((wordsBloc.state as WordsLoadSuccess).words));
      }
    });
  }

  final WordsBloc wordsBloc;
  late final StreamSubscription wordsSubscription;

  Future<void> _onFilterUpdated(FilterUpdated event, Emitter<FilteredWordsState> emit) async {
    if (wordsBloc.state is WordsLoadSuccess) {
      final getFilteredWords = _getFilteredWords((wordsBloc.state as WordsLoadSuccess).words, event.filter, event.query);
      emit(FilteredWordsLoadSuccess(filteredWords: getFilteredWords, currentFilter: event.filter));
    }
  }

  Future<void> _onWordsUpdated(WordsUpdated event, Emitter<FilteredWordsState> emit) async {
    final filter = (state is FilteredWordsLoadSuccess) ? (state as FilteredWordsLoadSuccess).currentFilter : Filter.all;
    final getFilteredWords = _getFilteredWords((wordsBloc.state as WordsLoadSuccess).words, filter, '');
    emit(FilteredWordsLoadSuccess(filteredWords: getFilteredWords, currentFilter: filter));
  }

  List<Word> _getFilteredWords(List<Word> words, Filter filter, String query) {
    return words.where((todo) {
      if (filter.isAll) {
        return true;
      }
      return todo.id.contains(query) || todo.romaji.contains(query) || todo.translate.contains(query);
    }).toList();
  }

  @override
  Future<void> close() {
    wordsSubscription.cancel();
    return super.close();
  }
}
