import 'package:kwriting/domain/domain.dart';

class ReviewController {
  const ReviewController({required this.statisticsRepository});

  final IStatisticsRepository statisticsRepository;

  Future<bool> get showRateApp async {
    return await statisticsRepository.trainingQuantity() % 10 == 0;
  }
}
