import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/src/domain/controllers/statistics.controller.dart';
import 'package:kwriting/src/domain/repositories/statistics.interface.repository.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  test('must return show hint quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository);
    when(() => repository.showHintQuantity()).thenReturn(13);

    expect(controller.showHintQuantity, 13);
    verify(() => repository.showHintQuantity()).called(1);
  });
  test('must return not show hint quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository);
    when(() => repository.notShowHintQuantity()).thenReturn(453);

    expect(controller.notShowHintQuantity, 453);
    verify(() => repository.notShowHintQuantity()).called(1);
  });
  test('must return only hiragana quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository);
    when(() => repository.onlyHiraganaQuantity()).thenReturn(34);

    expect(controller.onlyHiraganaQuantity, 34);
    verify(() => repository.onlyHiraganaQuantity()).called(1);
  });
  test('must return only katakana quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository);
    when(() => repository.onlyKatakanaQuantity()).thenReturn(678);

    expect(controller.onlyKatakanaQuantity, 678);
    verify(() => repository.onlyKatakanaQuantity()).called(1);
  });
  test('must return both quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository);
    when(() => repository.bothQuantity()).thenReturn(234);

    expect(controller.bothQuantity, 234);
    verify(() => repository.bothQuantity()).called(1);
  });
  test('must return training quantity', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository);
    when(() => repository.trainingQuantity()).thenReturn(159);

    expect(controller.trainingQuantity, 159);
    verify(() => repository.trainingQuantity()).called(1);
  });
  test('must return avg words per training', () {
    final repository = StatisticsRepositoryMock();
    final controller = StatisticsController(statisticsRepository: repository);
    when(() => repository.avgWordsPerTraining()).thenAnswer((invocation) => Future(() => 123.7));

    expect(controller.avgWordsPerTraining, completion(123.7));
    verify(() => repository.avgWordsPerTraining()).called(1);
  });
}

class StatisticsRepositoryMock extends Mock implements IStatisticsRepository {}
