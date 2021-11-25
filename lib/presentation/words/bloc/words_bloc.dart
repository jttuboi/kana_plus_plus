// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc({required this.wordsRepository}) : super(WordsLoadInProgress()) {
    on<WordsLoaded>(_onWordsLoaded);
  }

  final IWordsRepository wordsRepository;

  Future<void> _onWordsLoaded(WordsLoaded event, Emitter<WordsState> emit) async {
    try {
      final wordModels = await wordsRepository.fetchTodos();
      final words = wordModels.map((wordModel) => WordViewModel.fromWordModel(wordModel, languageCode: event.languageCode)).toList();
      emit(WordsLoadSuccess(words));
    } catch (e, s) {
      log('_onTodosLoaded', error: e, stackTrace: s);
      emit(WordsLoadFailure());
    }
  }
}
