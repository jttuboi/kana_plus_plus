// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/words/words.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc({required IWordsRepository wordsRepository}) : super(WordsLoadInProgress()) {
    _fetchWords = FetchWords(wordsRepository);
    on<WordsLoaded>(_onWordsLoaded);
  }

  late final FetchWords _fetchWords;

  Future<void> _onWordsLoaded(WordsLoaded event, Emitter<WordsState> emit) async {
    try {
      final words = await _fetchWords(NoParams());
      emit(WordsLoadSuccess(words));
    } catch (e, s) {
      log('_onTodosLoaded', error: e, stackTrace: s);
      emit(WordsLoadFailure());
    }
  }
}
