import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('ReviewController', () {
    final mockStatisticsRepository = MockStatisticsRepository();
    final reviewController = ReviewController(statisticsRepository: mockStatisticsRepository);

    test('shows the rate for app when training quantity is multiply of 10', () async {
      when(mockStatisticsRepository.trainingQuantity).thenAnswer((_) => Future.value(10));
      expect(reviewController.showRateApp, completion(isTrue));

      when(mockStatisticsRepository.trainingQuantity).thenAnswer((_) => Future.value(20));
      expect(reviewController.showRateApp, completion(isTrue));

      when(mockStatisticsRepository.trainingQuantity).thenAnswer((_) => Future.value(30));
      expect(reviewController.showRateApp, completion(isTrue));

      when(mockStatisticsRepository.trainingQuantity).thenAnswer((_) => Future.value(40));
      expect(reviewController.showRateApp, completion(isTrue));

      when(mockStatisticsRepository.trainingQuantity).thenAnswer((_) => Future.value(50));
      expect(reviewController.showRateApp, completion(isTrue));
    });

    test('does not show the rate for app when training quantity is not multiply of 10', () async {
      when(mockStatisticsRepository.trainingQuantity).thenAnswer((_) => Future.value(1));
      expect(reviewController.showRateApp, completion(isFalse));

      when(mockStatisticsRepository.trainingQuantity).thenAnswer((_) => Future.value(2));
      expect(reviewController.showRateApp, completion(isFalse));

      when(mockStatisticsRepository.trainingQuantity).thenAnswer((_) => Future.value(9));
      expect(reviewController.showRateApp, completion(isFalse));

      when(mockStatisticsRepository.trainingQuantity).thenAnswer((_) => Future.value(1));
      expect(reviewController.showRateApp, completion(isFalse));

      when(mockStatisticsRepository.trainingQuantity).thenAnswer((_) => Future.value(15));
      expect(reviewController.showRateApp, completion(isFalse));
    });
  });
}
