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
        super(const ListInitial()) {
    on<ListStarted>(_onListStarted);
    on<ListPreUpdated>(_onListPreUpdated);
    on<ListKanaChanged>(_onListKanaChanged);
    on<ListWordChanged>(_onListWordChanged);
    on<ListPageAnimationChanged>(_onListPageChanged);
    on<ListTrainingEnded>(_onListTrainingEnded);

    _writerSubscription = writerBloc.stream.listen(_onWriterStateEnd);
  }

  late final WriterBloc _writerBloc;
  final IWordsRepository _wordsRepository;
  final IStatisticsRepository _statisticsRepository;
  late final StreamSubscription _writerSubscription;

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

    emit(ListReady(words: wordViewModels));
    _writerBloc.add(WriterStarted(
      kanaId: wordViewModels[0].kanas[0].id,
      strokesForDraw: wordViewModels[0].kanas[0].strokes,
    ));
  }

  Future<void> _onListPreUpdated(ListPreUpdated event, Emitter<ListState> emit) async {
    emit(ListPreReady(wordIndex: event.wordIndex, kanaIndex: event.kanaIndex, words: event.words));
  }

  Future<void> _onListKanaChanged(ListKanaChanged event, Emitter<ListState> emit) async {
    final nextKanaIndex = event.kanaIndex + 1;
    final nextWordIndex = event.wordIndex;

    emit(ListKanaReady(wordIndex: nextWordIndex, kanaIndex: nextKanaIndex, words: event.words));
    _writerBloc.add(WriterStarted(
      kanaId: event.words[nextWordIndex].kanas[nextKanaIndex].id,
      strokesForDraw: event.words[nextWordIndex].kanas[nextKanaIndex].strokes,
    ));
  }

  Future<void> _onListWordChanged(ListWordChanged event, Emitter<ListState> emit) async {
    const nextKanaIndex = 0;
    final nextWordIndex = event.wordIndex + 1;

    // ignore: avoid_redundant_argument_values
    emit(ListWordReady(wordIndex: nextWordIndex, kanaIndex: nextKanaIndex, words: event.words));
    _writerBloc.add(WriterStarted(
      kanaId: event.words[nextWordIndex].kanas[nextKanaIndex].id,
      strokesForDraw: event.words[nextWordIndex].kanas[nextKanaIndex].strokes,
    ));
  }

  Future<void> _onListPageChanged(ListPageAnimationChanged event, Emitter<ListState> emit) async {
    emit(ListPageReady(
        changePageDurationInMilliseconds: event.changePageDurationInMilliseconds,
        wordIndex: event.wordIndex + 1,
        kanaIndex: event.kanaIndex,
        words: event.words));
  }

  Future<void> _onListTrainingEnded(ListTrainingEnded event, Emitter<ListState> emit) async {
    emit(TrainingEnded(words: event.words));
  }

  Future<void> _onWriterStateEnd(WriterState writerState) async {
    if (writerState is! WriterEnd) {
      return;
    }

    if (state is ListReady) {
      final listState = state as ListReady;

      final wordsUpdated = listState.words.copyWithNewKanaStatusAndUserStrokes(
        wordIndex: listState.wordIndex,
        kanaIndex: listState.kanaIndex,
        userStrokes: writerState.userStrokes,
        corrects: writerState.corrects,
      );

      // update current kana status in kana viewer (don't change to kana, word or end training status)
      add(ListPreUpdated(wordIndex: listState.wordIndex, kanaIndex: listState.kanaIndex, words: wordsUpdated));

      await _delayToShowOnlyTheKanaSituationUpdated();

      if (_isTrainingFinish(listState)) {
        await _updateStatistics(wordsUpdated);
        add(ListTrainingEnded(wordsUpdated));
      } else if (_isPageChange(listState)) {
        // change the page only, after change de page, update the data
        const changePageDurationInMilliseconds = 1000;
        add(ListPageAnimationChanged(
            changePageDurationInMilliseconds: changePageDurationInMilliseconds,
            wordIndex: listState.wordIndex,
            kanaIndex: listState.kanaIndex,
            words: wordsUpdated));

        await _delayToHoldTheDataUpdateUntilPageAnimationChanged(changePageDurationInMilliseconds);

        add(ListWordChanged(wordIndex: listState.wordIndex, words: wordsUpdated));
      } else {
        add(ListKanaChanged(wordIndex: listState.wordIndex, kanaIndex: listState.kanaIndex, words: wordsUpdated));
      }
    }
  }

  Future<void> _delayToShowOnlyTheKanaSituationUpdated() async => Future.delayed(const Duration(milliseconds: 500));

  Future<void> _delayToHoldTheDataUpdateUntilPageAnimationChanged(int changePageDurationInMilliseconds) async {
    return Future.delayed(Duration(milliseconds: changePageDurationInMilliseconds));
  }

  bool _isTrainingFinish(ListReady listState) => _isLastWord(listState) && _isLastKana(listState);

  bool _isPageChange(ListReady listState) => _isLastKana(listState);

  bool _isLastKana(ListReady listState) => listState.kanaIndex + 1 >= listState.words[listState.wordIndex].kanas.length;

  bool _isLastWord(ListReady listState) => listState.wordIndex + 1 >= listState.words.length;

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

    //await _statisticsRepository.saveTrainingStats(trainingStats);
  }

  @override
  Future<void> close() {
    _writerSubscription.cancel();
    return super.close();
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

  List<WordViewModel> copyWithNewKanaStatusAndUserStrokes({
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
            newKanas.add(this[w].kanas[k].copyWith(status: _calculateStatus(corrects), userStrokes: userStrokes));
          } else if (k == kanaIndex + 1) {
            newKanas.add(this[w].kanas[k].copyWith(status: KanaViewerStatus.select));
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
