// // ignore_for_file: unnecessary_lambdas

// import 'package:flutter_test/flutter_test.dart';
// import 'package:kwriting/features/training/training.dart';
// import 'package:mocktail/mocktail.dart';

// void main() {
//   final statisticsRepository = StatisticsRepositoryMock();
//   final reviewController = ReviewController(statisticsRepository: statisticsRepository);
//   test('must return true for show rating dialog when it has multiple of ten training quantity', () {
//     // talvez é bom mudar a frequencia de como aparece. tbm tem que ver se ele já deu um feedback
//     when(() => statisticsRepository.trainingQuantity()).thenReturn(0);
//     expect(reviewController.showRateApp, isTrue);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(10);
//     expect(reviewController.showRateApp, isTrue);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(20);
//     expect(reviewController.showRateApp, isTrue);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(30);
//     expect(reviewController.showRateApp, isTrue);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(40);
//     expect(reviewController.showRateApp, isTrue);
//   });
//   test('must return false for show rating dialog when it has not multiple of ten training quantity', () {
//     when(() => statisticsRepository.trainingQuantity()).thenReturn(1);
//     expect(reviewController.showRateApp, isFalse);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(2);
//     expect(reviewController.showRateApp, isFalse);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(3);
//     expect(reviewController.showRateApp, isFalse);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(5);
//     expect(reviewController.showRateApp, isFalse);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(9);
//     expect(reviewController.showRateApp, isFalse);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(11);
//     expect(reviewController.showRateApp, isFalse);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(13);
//     expect(reviewController.showRateApp, isFalse);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(15);
//     expect(reviewController.showRateApp, isFalse);

//     when(() => statisticsRepository.trainingQuantity()).thenReturn(19);
//     expect(reviewController.showRateApp, isFalse);
//   });
// }

// class StatisticsRepositoryMock extends Mock implements IStatisticsRepository {}
