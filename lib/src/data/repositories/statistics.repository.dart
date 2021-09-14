import 'package:hive/hive.dart';
import 'package:kana_plus_plus/src/data/singletons/database.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/training_stats.dart';
import 'package:kana_plus_plus/src/domain/repositories/statistics.interface.repository.dart';

class StatisticsRepository implements IStatisticsRepository {
  @override
  void increaseShowHintQuantity() {
    Database.setInt(DatabaseTag.showHintQuantity, Database.getInt(DatabaseTag.showHintQuantity) + 1);
  }

  @override
  void increaseNotShowHintQuantity() {
    Database.setInt(DatabaseTag.notShowHintQuantity, Database.getInt(DatabaseTag.notShowHintQuantity) + 1);
  }

  @override
  void increaseOnlyHiraganaQuantity() {
    Database.setInt(DatabaseTag.onlyHiraganaQuantity, Database.getInt(DatabaseTag.onlyHiraganaQuantity) + 1);
  }

  @override
  void increaseOnlyKatakanaQuantity() {
    Database.setInt(DatabaseTag.onlyKatakanaQuantity, Database.getInt(DatabaseTag.onlyKatakanaQuantity) + 1);
  }

  @override
  void increaseBothQuantity() {
    Database.setInt(DatabaseTag.bothQuantity, Database.getInt(DatabaseTag.bothQuantity) + 1);
  }

  @override
  void increaseTrainingQuantity() {
    Database.setInt(DatabaseTag.trainingQuantity, Database.getInt(DatabaseTag.trainingQuantity) + 1);
  }

  @override
  void increaseWordCorrectQuantity() {
    Database.setInt(DatabaseTag.wordCorrectQuantity, Database.getInt(DatabaseTag.wordCorrectQuantity) + 1);
  }

  @override
  void increaseWordWrongQuantity() {
    Database.setInt(DatabaseTag.wordWrongQuantity, Database.getInt(DatabaseTag.wordWrongQuantity) + 1);
  }

  @override
  void increaseKanaCorrectQuantity() {
    Database.setInt(DatabaseTag.kanaCorrectQuantity, Database.getInt(DatabaseTag.kanaCorrectQuantity) + 1);
  }

  @override
  void increaseKanaWrongQuantity() {
    Database.setInt(DatabaseTag.kanaWrongQuantity, Database.getInt(DatabaseTag.kanaWrongQuantity) + 1);
  }

  @override
  void increaseSpecificWordCorrectQuantity(String wordId) {
    Database.setInt('c$wordId', Database.getInt('c$wordId') + 1);
  }

  @override
  void increaseSpecificWordWrongQuantity(String wordId) {
    Database.setInt('w$wordId', Database.getInt('w$wordId') + 1);
  }

  @override
  void increaseSpecificKanaCorrectQuantity(String kanaId) {
    Database.setInt('c$kanaId', Database.getInt('c$kanaId') + 1);
  }

  @override
  void increaseSpecificKanaWrongQuantity(String kanaId) {
    Database.setInt('w$kanaId', Database.getInt('w$kanaId') + 1);
  }

  @override
  void saveTrainingStats(TrainingStats trainingStats) {
    Hive.openLazyBox<TrainingStats>(DatabaseTag.trainingStats).then((box) {
      box.add(trainingStats);
    });
  }

  @override
  int bothQuantity() {
    return Database.getInt(DatabaseTag.bothQuantity);
  }

  @override
  int notShowHintQuantity() {
    return Database.getInt(DatabaseTag.notShowHintQuantity);
  }

  @override
  int onlyHiraganaQuantity() {
    return Database.getInt(DatabaseTag.onlyHiraganaQuantity);
  }

  @override
  int onlyKatakanaQuantity() {
    return Database.getInt(DatabaseTag.onlyKatakanaQuantity);
  }

  @override
  int showHintQuantity() {
    return Database.getInt(DatabaseTag.showHintQuantity);
  }

  @override
  int trainingQuantity() {
    return Database.getInt(DatabaseTag.trainingQuantity);
  }

  @override
  Future<double> avgWordsPerTraining() async {
    final box = await Hive.openBox<TrainingStats>(DatabaseTag.trainingStats);
    return box.values.map((trainingStats) => trainingStats.wordsQuantity).reduce((total, wordQuantity) => total + wordQuantity) / box.values.length;
  }

  @override
  int specificWordCorrectQuantity(String wordId) {
    return Database.getInt('c$wordId');
  }

  @override
  int specificWordWrongQuantity(String wordId) {
    return Database.getInt('w$wordId');
  }

  @override
  int specificKanaCorrectQuantity(String kanaId) {
    return Database.getInt('c$kanaId');
  }

  @override
  int specificKanaWrongQuantity(String kanaId) {
    return Database.getInt('w$kanaId');
  }
}
