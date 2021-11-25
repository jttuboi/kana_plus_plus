import 'package:hive/hive.dart';
import 'package:kwriting/domain/domain.dart';

class StatisticsRepository implements IStatisticsRepository {
  //TODO modificar para box

  @override
  void increaseShowHintQuantity() {
    //Database.storage.setInt(DatabaseTag.showHintQuantity, Database.storage.getInt(DatabaseTag.showHintQuantity) + 1);
  }

  @override
  void increaseNotShowHintQuantity() {
    // Database.storage.setInt(DatabaseTag.notShowHintQuantity, Database.storage.getInt(DatabaseTag.notShowHintQuantity) + 1);
  }

  @override
  void increaseOnlyHiraganaQuantity() {
    // Database.storage.setInt(DatabaseTag.onlyHiraganaQuantity, Database.storage.getInt(DatabaseTag.onlyHiraganaQuantity) + 1);
  }

  @override
  void increaseOnlyKatakanaQuantity() {
    // Database.storage.setInt(DatabaseTag.onlyKatakanaQuantity, Database.storage.getInt(DatabaseTag.onlyKatakanaQuantity) + 1);
  }

  @override
  void increaseBothQuantity() {
    //Database.storage.setInt(DatabaseTag.bothQuantity, Database.storage.getInt(DatabaseTag.bothQuantity) + 1);
  }

  @override
  void increaseTrainingQuantity() {
    //Database.storage.setInt(DatabaseTag.trainingQuantity, Database.storage.getInt(DatabaseTag.trainingQuantity) + 1);
  }

  @override
  void increaseWordCorrectQuantity() {
    //Database.storage.setInt(DatabaseTag.wordCorrectQuantity, Database.storage.getInt(DatabaseTag.wordCorrectQuantity) + 1);
  }

  @override
  void increaseWordWrongQuantity() {
    //Database.storage.setInt(DatabaseTag.wordWrongQuantity, Database.storage.getInt(DatabaseTag.wordWrongQuantity) + 1);
  }

  @override
  void increaseKanaCorrectQuantity() {
    //Database.storage.setInt(DatabaseTag.kanaCorrectQuantity, Database.storage.getInt(DatabaseTag.kanaCorrectQuantity) + 1);
  }

  @override
  void increaseKanaWrongQuantity() {
    //Database.storage.setInt(DatabaseTag.kanaWrongQuantity, Database.storage.getInt(DatabaseTag.kanaWrongQuantity) + 1);
  }

  @override
  void increaseSpecificWordCorrectQuantity(String wordId) {
    //Database.storage.setInt('c$wordId', Database.storage.getInt('c$wordId') + 1);
  }

  @override
  void increaseSpecificWordWrongQuantity(String wordId) {
    //Database.storage.setInt('w$wordId', Database.storage.getInt('w$wordId') + 1);
  }

  @override
  void increaseSpecificKanaCorrectQuantity(String kanaId) {
    //Database.storage.setInt('c$kanaId', Database.storage.getInt('c$kanaId') + 1);
  }

  @override
  void increaseSpecificKanaWrongQuantity(String kanaId) {
    //Database.storage.setInt('w$kanaId', Database.storage.getInt('w$kanaId') + 1);
  }

  @override
  void saveTrainingStats(TrainingStats trainingStats) {
    Hive.openLazyBox<TrainingStats>(DatabaseTag.trainingStats).then((box) {
      box.add(trainingStats);
    });
  }

  @override
  int bothQuantity() {
    return 0;
    //return Database.storage.getInt(DatabaseTag.bothQuantity);
  }

  @override
  int notShowHintQuantity() {
    return 0;
    //return Database.storage.getInt(DatabaseTag.notShowHintQuantity);
  }

  @override
  int onlyHiraganaQuantity() {
    return 0;
    //return Database.storage.getInt(DatabaseTag.onlyHiraganaQuantity);
  }

  @override
  int onlyKatakanaQuantity() {
    return 0;
    //return Database.storage.getInt(DatabaseTag.onlyKatakanaQuantity);
  }

  @override
  int showHintQuantity() {
    return 0;
    //return Database.storage.getInt(DatabaseTag.showHintQuantity);
  }

  @override
  int trainingQuantity() {
    return 0;
    //return Database.storage.getInt(DatabaseTag.trainingQuantity);
  }

  @override
  Future<double> avgWordsPerTraining() async {
    return Future.value(1.0);
    // final box = await Hive.openBox<TrainingStats>(DatabaseTag.trainingStats);
    // return box.values.map((trainingStats) => trainingStats.wordsQuantity).reduce((total, wordQuantity) => total + wordQuantity) / box.values.length;
  }

  @override
  int specificWordCorrectQuantity(String wordId) {
    return 0;
    // return Database.storage.getInt('c$wordId');
  }

  @override
  int specificWordWrongQuantity(String wordId) {
    return 0;
    //return Database.storage.getInt('w$wordId');
  }

  @override
  int specificKanaCorrectQuantity(String kanaId) {
    return 0;
    //return Database.storage.getInt('c$kanaId');
  }

  @override
  int specificKanaWrongQuantity(String kanaId) {
    return 0;
    //return Database.storage.getInt('w$kanaId');
  }
}
