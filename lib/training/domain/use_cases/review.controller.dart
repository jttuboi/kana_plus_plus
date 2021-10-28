import 'package:kwriting/training/training.dart';

class ReviewController {
  const ReviewController({required this.statisticsRepository});

  final IStatisticsRepository statisticsRepository;

  bool get showRateApp {
    return statisticsRepository.trainingQuantity() % 10 == 0;
  }
}
