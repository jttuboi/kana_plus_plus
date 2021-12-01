// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  WordsBloc({required this.wordsRepository, required this.statisticsRepository}) : super(WordsLoadInProgress()) {
    on<WordsLoaded>(_onWordsLoaded);
  }

  final IWordsRepository wordsRepository;
  final IStatisticsRepository statisticsRepository;

  Future<void> _onWordsLoaded(WordsLoaded event, Emitter<WordsState> emit) async {
    try {
      final wordModels = await wordsRepository.fetchTodos();

      final wordIds = wordModels.map((wordModel) => wordModel.id).toList();
      final correctWordCount = await statisticsRepository.specificWordCorrectQuantityByWordIds(wordIds);
      final wrongWordCount = await statisticsRepository.specificWordWrongQuantityByWordIds(wordIds);

      final kanaIds = wordModels.fold<List<String>>(<String>[], (previousList, wordModel) {
        return previousList..addAll(wordModel.kanas.map((kanaModel) => kanaModel.id).toList());
      });
      final correctKanaCount = await statisticsRepository.specificKanaCorrectQuantityByKanaIds(kanaIds);
      final wrongKanaCount = await statisticsRepository.specificKanaWrongQuantityByKanaIds(kanaIds);

      final words = wordModels.map((wordModel) {
        return WordViewModel.fromWordModel(
          wordModel,
          languageCode: event.languageCode,
          correctWordCount: correctWordCount,
          wrongWordCount: wrongWordCount,
          correctKanaCount: correctKanaCount,
          wrongKanaCount: wrongKanaCount,
        );
      }).toList()
        ..sort((word1, word2) => word1.id.compareTo(word2.id));
      emit(WordsLoadSuccess(words));
    } catch (e, s) {
      log('_onTodosLoaded', error: e, stackTrace: s);
      emit(WordsLoadFailure());
    }
  }
}
