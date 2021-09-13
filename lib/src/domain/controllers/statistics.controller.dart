import 'package:kana_plus_plus/src/domain/core/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/training_stats.dart';
import 'package:kana_plus_plus/src/domain/repositories/statistics.interface.repository.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';

class StatisticsController {
  StatisticsController({
    required this.statisticsRepository,
    required this.showHint,
    required this.kanaType,
    required this.quantityOfWords,
  });

  final IStatisticsRepository statisticsRepository;
  final bool showHint;
  final KanaType kanaType;
  final int quantityOfWords;

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

  int get showHintQuantity => statisticsRepository.showHintQuantity();

  int get notShowHintQuantity => statisticsRepository.notShowHintQuantity();

  int get onlyHiraganaQuantity => statisticsRepository.onlyHiraganaQuantity();

  int get onlyKatakanaQuantity => statisticsRepository.onlyKatakanaQuantity();

  int get bothQuantity => statisticsRepository.bothQuantity();

  int get trainingQuantity => statisticsRepository.trainingQuantity();

  double get avgWordsPerTraining {
    final wordQuantities = statisticsRepository.wordQuantitiesOfTraining();
    return wordQuantities.map((wordQuantity) => wordQuantity).reduce((total, wordQuantity) => total + wordQuantity) / wordQuantities.length;
  }
}
