import 'package:kwriting/domain/domain.dart';

abstract class IStatisticsRepository {
  Future<void> increaseShowHintQuantity();

  Future<void> increaseNotShowHintQuantity();

  Future<void> increaseOnlyHiraganaQuantity();

  Future<void> increaseOnlyKatakanaQuantity();

  Future<void> increaseBothQuantity();

  Future<void> increaseTrainingQuantity();

  Future<void> increaseWordCorrectQuantity();

  Future<void> increaseWordWrongQuantity();

  Future<void> increaseKanaCorrectQuantity();

  Future<void> increaseKanaWrongQuantity();

  Future<void> increaseSpecificWordCorrectQuantity(String wordId);

  Future<void> increaseSpecificWordWrongQuantity(String wordId);

  Future<void> increaseSpecificKanaCorrectQuantity(String kanaId);

  Future<void> increaseSpecificKanaWrongQuantity(String kanaId);

  Future<void> saveTrainingStats(TrainingStats trainingStats);

  Future<int> showHintQuantity();

  Future<int> notShowHintQuantity();

  Future<int> onlyHiraganaQuantity();

  Future<int> onlyKatakanaQuantity();

  Future<int> bothQuantity();

  Future<int> trainingQuantity();

  Future<double> avgWordsPerTraining();

  Future<Map<String, int>> specificWordCorrectQuantityByWordIds(List<String> wordIds);

  Future<Map<String, int>> specificWordWrongQuantityByWordIds(List<String> wordIds);

  Future<Map<String, int>> specificKanaCorrectQuantityByKanaIds(List<String> kanaIds);

  Future<Map<String, int>> specificKanaWrongQuantityByKanaIds(List<String> kanaIds);

  Future<List<TrainingStats>> getTrainingStats();
}
