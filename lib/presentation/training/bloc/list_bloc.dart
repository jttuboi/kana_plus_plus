import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc(WriterBloc writerBloc, IWordsRepository wordsRepository, IStatisticsRepository statisticsRepository)
      : _writerBloc = writerBloc,
        _wordsRepository = wordsRepository,
        _statisticsRepository = statisticsRepository,
        super(ListInitial()) {
    on<ListStarted>(_onListStarted);
    on<ListWordUpdated>(_onWordUpdated);
    on<ListKanaUpdated>(_onKanaUpdated);
    on<ListClosed>(_onListClosed);

    _writerSubscription = writerBloc.stream.listen(_onWriterStateEnd);
  }

  final IWordsRepository _wordsRepository;
  final IStatisticsRepository _statisticsRepository;
  late final StreamSubscription _writerSubscription;
  late final WriterBloc _writerBloc;

  late final TrainingSettings _trainingSettings;

  Future<void> _onListStarted(ListStarted event, Emitter<ListState> emit) async {
    _trainingSettings = event.trainingSettings;

    final wordModels = (event.trainingSettings.kanaType.isBoth)
        ? await _wordsRepository.fetchTodos()
        : (await _wordsRepository.fetchTodos()).where((wordModel) => wordModel.kanaType == event.trainingSettings.kanaType).toList();
    final randomWordModels = (wordModels..shuffle()).take(event.trainingSettings.quantityOfWords);
    final wordViewModels = randomWordModels.map((wordModel) {
      return WordViewModel.fromWordModel(wordModel, languageCode: event.trainingSettings.languageCode);
    }).toList();

    await Future.delayed(const Duration(milliseconds: 200));

    emit(ListReady(words: wordViewModels));
    _writerBloc.add(WriterStarted(
      kanaId: wordViewModels[0].kanas[0].id,
      strokesQuantity: wordViewModels[0].kanas[0].strokesQuantity,
      strokesForDraw: const <String>[
        'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
        'm 49.76,17.62 c 0.88,1 1.82,3.26 1.38,5.25 -3.75,16.75 -6.25,38.13 -5.13,53.63 0.41,5.7 1.88,10.88 3.38,13.62',
        'm 65.63,44.12 c 0.75,1.12 1.16,4.39 0.5,6.12 C 61.51,62.5 54.89,74 40.76,86 33.9,91.83 24.88,89.75 24.51,77.62 24.17,66.75 37.89,54.5 56.89,50.88 c 12.42,-2.37 27,1.38 30.5,12.75 C 91.44,76.81 83.63,90 66.51,94.12',
        'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
        'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
        'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
        'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
        'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
        'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
        'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
        'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
        'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
      ],
    ));
  }

  Future<void> _onWordUpdated(ListWordUpdated event, Emitter<ListState> emit) async {
    emit(ListWordReady(kanaIndex: event.kanaIndex, wordIndex: event.wordIndex, words: event.words));
  }

  Future<void> _onKanaUpdated(ListKanaUpdated event, Emitter<ListState> emit) async {
    emit(ListKanaReady(kanaIndex: event.kanaIndex, wordIndex: event.wordIndex, words: event.words));
  }

  Future<void> _onListClosed(ListClosed event, Emitter<ListState> emit) async {
    emit(TrainingEnded(words: event.words));
  }

  Future<void> _onWriterStateEnd(WriterState writerState) async {
    if (writerState is WriterEnd) {
      if (state is ListReady) {
        final listState = state as ListReady;

        // update words with kana written and the next
        final newWords = listState.words.copyWith(
          wordIndex: listState.wordIndex,
          kanaIndex: listState.kanaIndex,
          userStrokes: writerState.userStrokes,
          corrects: writerState.corrects,
        );

        var nextKanaIndex = listState.kanaIndex + 1;
        var nextWordIndex = listState.wordIndex;

        if (_lastKana(nextKanaIndex, listState)) {
          nextKanaIndex = 0;
          nextWordIndex++;
        }

        if (_lastWord(nextWordIndex, listState)) {
          await _updateStatistics(newWords);
          add(ListClosed(newWords));
        } else if (_changePage(nextWordIndex, listState)) {
          await _delayedBeforeChangePage();
          add(ListWordUpdated(wordIndex: nextWordIndex, kanaIndex: nextKanaIndex, words: newWords));
          _writerBloc.add(WriterStarted(
            kanaId: newWords[nextWordIndex].kanas[nextKanaIndex].id,
            strokesQuantity: newWords[nextWordIndex].kanas[nextKanaIndex].strokesQuantity,
            strokesForDraw: const <String>[
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 49.76,17.62 c 0.88,1 1.82,3.26 1.38,5.25 -3.75,16.75 -6.25,38.13 -5.13,53.63 0.41,5.7 1.88,10.88 3.38,13.62',
              'm 65.63,44.12 c 0.75,1.12 1.16,4.39 0.5,6.12 C 61.51,62.5 54.89,74 40.76,86 33.9,91.83 24.88,89.75 24.51,77.62 24.17,66.75 37.89,54.5 56.89,50.88 c 12.42,-2.37 27,1.38 30.5,12.75 C 91.44,76.81 83.63,90 66.51,94.12',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
            ],
          ));
        } else {
          add(ListKanaUpdated(wordIndex: nextWordIndex, kanaIndex: nextKanaIndex, words: newWords));
          _writerBloc.add(WriterStarted(
            kanaId: newWords[nextWordIndex].kanas[nextKanaIndex].id,
            strokesQuantity: newWords[nextWordIndex].kanas[nextKanaIndex].strokesQuantity,
            strokesForDraw: const <String>[
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 49.76,17.62 c 0.88,1 1.82,3.26 1.38,5.25 -3.75,16.75 -6.25,38.13 -5.13,53.63 0.41,5.7 1.88,10.88 3.38,13.62',
              'm 65.63,44.12 c 0.75,1.12 1.16,4.39 0.5,6.12 C 61.51,62.5 54.89,74 40.76,86 33.9,91.83 24.88,89.75 24.51,77.62 24.17,66.75 37.89,54.5 56.89,50.88 c 12.42,-2.37 27,1.38 30.5,12.75 C 91.44,76.81 83.63,90 66.51,94.12',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
              'm 31.01,33 c 0.88,0.88 2.75,1.82 5.25,1.75 8.62,-0.25 20,-2.12 29.5,-4.25 1.51,-0.34 4.62,-0.88 6.62,-0.5',
            ],
          ));
        }
      }
    }
  }

  bool _lastKana(int nextKanaIndex, ListReady listState) => nextKanaIndex >= listState.words[listState.wordIndex].kanas.length;

  bool _lastWord(int nextWordIndex, ListReady listState) => nextWordIndex >= listState.words.length;

  bool _changePage(int nextWordIndex, ListReady listState) => nextWordIndex != listState.wordIndex;

  @override
  Future<void> close() {
    _writerSubscription.cancel();
    return super.close();
  }

  Future<void> _delayedBeforeChangePage() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _updateStatistics(List<WordViewModel> words) async {
    if (_trainingSettings.showHint) {
      await _statisticsRepository.increaseShowHintQuantity();
    } else {
      await _statisticsRepository.increaseNotShowHintQuantity();
    }

    if (_trainingSettings.kanaType.isOnlyHiragana) {
      await _statisticsRepository.increaseOnlyHiraganaQuantity();
    } else if (_trainingSettings.kanaType.isOnlyKatakana) {
      await _statisticsRepository.increaseOnlyKatakanaQuantity();
    } else {
      await _statisticsRepository.increaseBothQuantity();
    }

    await _statisticsRepository.increaseTrainingQuantity();

    final trainingStats = words.toTrainingStats(
      _trainingSettings.showHint,
      _trainingSettings.kanaType,
      _trainingSettings.quantityOfWords,
    );

    for (final wordEnd in trainingStats.words) {
      if (wordEnd.correct) {
        await _statisticsRepository.increaseWordCorrectQuantity();
        await _statisticsRepository.increaseSpecificWordCorrectQuantity(wordEnd.id);
      } else {
        await _statisticsRepository.increaseWordWrongQuantity();
        await _statisticsRepository.increaseSpecificWordWrongQuantity(wordEnd.id);
      }

      for (final kanaEnd in wordEnd.kanas) {
        if (kanaEnd.correct) {
          await _statisticsRepository.increaseKanaCorrectQuantity();
          await _statisticsRepository.increaseSpecificKanaCorrectQuantity(kanaEnd.id);
        } else {
          await _statisticsRepository.increaseKanaWrongQuantity();
          await _statisticsRepository.increaseSpecificKanaWrongQuantity(kanaEnd.id);
        }
      }
    }

    await _statisticsRepository.saveTrainingStats(trainingStats);
  }
}

extension ListWord on List<WordViewModel> {
  TrainingStats toTrainingStats(bool showHint, KanaType kanaType, int quantityOfWords) {
    return TrainingStats(
      showHint: showHint,
      type: kanaType,
      wordsQuantity: quantityOfWords,
      words: map((wordViewModel) => wordViewModel.toWordStats()).toList(),
    );
  }

  List<WordViewModel> copyWith({
    required int wordIndex,
    required int kanaIndex,
    required List<List<Offset>> userStrokes,
    required List<bool> corrects,
  }) {
    final newWords = <WordViewModel>[];
    for (var w = 0; w < length; w++) {
      if (w == wordIndex) {
        final newKanas = <KanaViewModel>[];
        for (var k = 0; k < this[w].kanas.length; k++) {
          if (k == kanaIndex) {
            newKanas.add(this[w].kanas[k].copyWith(
                  status: _calculateStatus(corrects),
                  userStrokes: userStrokes,
                ));
          } else if (k == kanaIndex + 1) {
            newKanas.add(this[w].kanas[k].copyWith(
                  status: KanaViewerStatus.select,
                ));
          } else {
            newKanas.add(this[w].kanas[k]);
          }
        }
        newWords.add(this[w].copyWith(kanas: newKanas));
      } else {
        newWords.add(this[w]);
      }
    }
    return newWords;
  }

  KanaViewerStatus _calculateStatus(List<bool> corrects) {
    var correctCount = 0;
    var wrongCount = 0;

    for (final correct in corrects) {
      if (correct) {
        correctCount++;
      } else {
        wrongCount++;
      }
    }

    return (correctCount >= wrongCount) ? KanaViewerStatus.correct : KanaViewerStatus.wrong;
  }
}
