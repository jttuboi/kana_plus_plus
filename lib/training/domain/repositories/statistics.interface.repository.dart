import 'package:kwriting/training/domain/entities/training_stats.dart';

abstract class IStatisticsRepository {
  void increaseShowHintQuantity();

  void increaseNotShowHintQuantity();

  void increaseOnlyHiraganaQuantity();

  void increaseOnlyKatakanaQuantity();

  void increaseBothQuantity();

  void increaseTrainingQuantity();

  void increaseWordCorrectQuantity();

  void increaseWordWrongQuantity();

  void increaseKanaCorrectQuantity();

  void increaseKanaWrongQuantity();

  void increaseSpecificWordCorrectQuantity(String wordId);

  void increaseSpecificWordWrongQuantity(String wordId);

  void increaseSpecificKanaCorrectQuantity(String kanaId);

  void increaseSpecificKanaWrongQuantity(String kanaId);

  void saveTrainingStats(TrainingStats trainingStats);

  int showHintQuantity();

  int notShowHintQuantity();

  int onlyHiraganaQuantity();

  int onlyKatakanaQuantity();

  int bothQuantity();

  int trainingQuantity();

  Future<double> avgWordsPerTraining();

  int specificWordCorrectQuantity(String wordId);

  int specificWordWrongQuantity(String wordId);

  int specificKanaCorrectQuantity(String kanaId);

  int specificKanaWrongQuantity(String kanaId);
}
