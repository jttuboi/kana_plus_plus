import 'package:flutter/widgets.dart';
import 'package:kwriting/src/domain/entities/kana_to_writer.dart';
import 'package:kwriting/src/domain/entities/kana_viewer_content.dart';
import 'package:kwriting/src/domain/entities/training_stats.dart';
import 'package:kwriting/src/domain/entities/word.dart';
import 'package:kwriting/src/domain/entities/word_viewer_content.dart';
import 'package:kwriting/src/domain/repositories/statistics.interface.repository.dart';
import 'package:kwriting/src/domain/repositories/word.interface.repository.dart';
import 'package:kwriting/src/domain/support/kana_checker.dart';
import 'package:kwriting/src/domain/utils/kana_type.dart';
import 'package:kwriting/src/domain/utils/update_kana_situation.dart';
import 'package:kwriting/src/presentation/arguments/word_result.dart';

class TrainingController {
  TrainingController({
    required this.wordRepository,
    required this.statisticsRepository,
    required this.kanaChecker,
    required this.showHint,
    required this.kanaType,
    required this.quantityOfWords,
  });

  final IWordRepository wordRepository;
  final IStatisticsRepository statisticsRepository;
  final IKanaChecker kanaChecker;

  final bool showHint;
  final KanaType kanaType;
  final int quantityOfWords;

  int wordIdx = 0;
  int kanaIdx = 0;

  List<WordViewerContent> wordsToTraining = [];

  Future<bool> get isReady async {
    await kanaChecker.load();
    _fillWordsToTraining();
    return true;
  }

  String get wordImageUrl => wordsToTraining[wordIdx].imageUrl;

  String get wordTranslate => wordsToTraining[wordIdx].translate;

  int get numberOfWordsToStudy => wordsToTraining.length;

  KanaToWrite get currentKanaToWrite => KanaToWrite(
        id: wordsToTraining[wordIdx].kanas[kanaIdx].id,
        type: wordsToTraining[wordIdx].kanas[kanaIdx].kanaType,
        hintImageUrl: wordsToTraining[wordIdx].kanas[kanaIdx].kanaImageUrl,
        maxStrokes: wordsToTraining[wordIdx].kanas[kanaIdx].strokesQuantity,
      );

  int maxKanasOfWord(int currentWordIdx) => wordsToTraining[currentWordIdx].kanas.length;

  KanaViewerContent kanaOfWord(int currentWordIdx, int currentKanaIdx) => wordsToTraining[currentWordIdx].kanas[currentKanaIdx];

  UpdateKanaSituation updateKana(List<List<Offset>> strokesNormalized, String kanaIdWrote) {
    wordsToTraining[wordIdx].kanas[kanaIdx] =
        KanaViewerContent.withUpdatedData(wordsToTraining[wordIdx].kanas[kanaIdx], kanaIdWrote, strokesNormalized);

    // change to next kanaContent
    kanaIdx++;
    UpdateKanaSituation situation = UpdateKanaSituation.changeKana;

    // if not the last kanaContent, update kanaContent to status next
    if (kanaIdx < wordsToTraining[wordIdx].kanas.length) {
      wordsToTraining[wordIdx].kanas[kanaIdx] = KanaViewerContent.withStatusNext(wordsToTraining[wordIdx].kanas[kanaIdx]);
    }
    // else is the last kanaContent, change the wordContent
    else {
      kanaIdx = 0;
      wordIdx += 1;
      situation = UpdateKanaSituation.changeWord;
    }

    // in case is the last wordContent
    if (wordIdx >= wordsToTraining.length) {
      situation = UpdateKanaSituation.changeTheLastWord;
    }
    return situation;
  }

  List<WordResult> get wordsResult {
    return wordsToTraining.map((wordContent) => WordResult.fromWordViewerContent(wordContent)).toList();
  }

  void _fillWordsToTraining() {
    wordsToTraining.clear();
    final List<Word> words = wordRepository.getWordsForTraining(kanaType, quantityOfWords);
    wordsToTraining = words.map((word) => WordViewerContent.fromWord(word)).toList();
  }

  void updateStatistics(List<WordResult> wordsResult) {
    if (showHint) {
      statisticsRepository.increaseShowHintQuantity();
    } else {
      statisticsRepository.increaseNotShowHintQuantity();
    }

    if (kanaType.isOnlyHiragana) {
      statisticsRepository.increaseOnlyHiraganaQuantity();
    } else if (kanaType.isOnlyKatakana) {
      statisticsRepository.increaseOnlyKatakanaQuantity();
    } else {
      statisticsRepository.increaseBothQuantity();
    }

    statisticsRepository.increaseTrainingQuantity();

    final trainingStats = TrainingStats.fromWordsResult(showHint, kanaType, quantityOfWords, wordsResult);

    for (final wordEnd in trainingStats.words) {
      if (wordEnd.correct) {
        statisticsRepository.increaseWordCorrectQuantity();
        statisticsRepository.increaseSpecificWordCorrectQuantity(wordEnd.id);
      } else {
        statisticsRepository.increaseWordWrongQuantity();
        statisticsRepository.increaseSpecificWordWrongQuantity(wordEnd.id);
      }

      for (final kanaEnd in wordEnd.kanas) {
        if (kanaEnd.correct) {
          statisticsRepository.increaseKanaCorrectQuantity();
          statisticsRepository.increaseSpecificKanaCorrectQuantity(kanaEnd.id);
        } else {
          statisticsRepository.increaseKanaWrongQuantity();
          statisticsRepository.increaseSpecificKanaWrongQuantity(kanaEnd.id);
        }
      }
    }

    statisticsRepository.saveTrainingStats(trainingStats);
  }
}
