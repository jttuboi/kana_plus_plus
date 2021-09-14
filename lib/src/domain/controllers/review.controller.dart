import 'package:kana_plus_plus/src/domain/repositories/statistics.interface.repository.dart';

class ReviewController {
  const ReviewController({required this.statisticsRepository});

  final IStatisticsRepository statisticsRepository;

  bool get showRateApp {
    return statisticsRepository.trainingQuantity() % 10 == 0;
  }
}
