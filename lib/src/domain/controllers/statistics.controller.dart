import 'package:kwriting/src/domain/repositories/statistics.interface.repository.dart';

class StatisticsController {
  StatisticsController({
    required this.statisticsRepository,
  });

  final IStatisticsRepository statisticsRepository;

  int get showHintQuantity => statisticsRepository.showHintQuantity();

  int get notShowHintQuantity => statisticsRepository.notShowHintQuantity();

  int get onlyHiraganaQuantity => statisticsRepository.onlyHiraganaQuantity();

  int get onlyKatakanaQuantity => statisticsRepository.onlyKatakanaQuantity();

  int get bothQuantity => statisticsRepository.bothQuantity();

  int get trainingQuantity => statisticsRepository.trainingQuantity();

  Future<double> get avgWordsPerTraining => statisticsRepository.avgWordsPerTraining();
}
