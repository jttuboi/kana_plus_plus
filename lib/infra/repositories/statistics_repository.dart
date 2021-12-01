import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';

class StatisticsRepository implements IStatisticsRepository {
  StatisticsRepository(this.database);

  IDatabase database;

  @override
  Future<void> increaseShowHintQuantity() async {
    await database.load(BoxTag.statisticCount);
    await database.put(DatabaseTag.showHintQuantity, await database.get(DatabaseTag.showHintQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseNotShowHintQuantity() async {
    await database.load(BoxTag.statisticCount);
    await database.put(DatabaseTag.notShowHintQuantity, await database.get(DatabaseTag.notShowHintQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseOnlyHiraganaQuantity() async {
    await database.load(BoxTag.statisticCount);
    await database.put(DatabaseTag.onlyHiraganaQuantity, await database.get(DatabaseTag.onlyHiraganaQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseOnlyKatakanaQuantity() async {
    await database.load(BoxTag.statisticCount);
    await database.put(DatabaseTag.onlyKatakanaQuantity, await database.get(DatabaseTag.onlyKatakanaQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseBothQuantity() async {
    await database.load(BoxTag.statisticCount);
    await database.put(DatabaseTag.bothQuantity, await database.get(DatabaseTag.bothQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseTrainingQuantity() async {
    await database.load(BoxTag.statisticCount);
    await database.put(DatabaseTag.trainingQuantity, await database.get(DatabaseTag.trainingQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseWordCorrectQuantity() async {
    await database.load(BoxTag.statisticCount);
    await database.put(DatabaseTag.wordCorrectQuantity, await database.get(DatabaseTag.wordCorrectQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseWordWrongQuantity() async {
    await database.load(BoxTag.statisticCount);
    await database.put(DatabaseTag.wordWrongQuantity, await database.get(DatabaseTag.wordWrongQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseKanaCorrectQuantity() async {
    await database.load(BoxTag.statisticCount);
    await database.put(DatabaseTag.kanaCorrectQuantity, await database.get(DatabaseTag.kanaCorrectQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseKanaWrongQuantity() async {
    await database.load(BoxTag.statisticCount);
    await database.put(DatabaseTag.kanaWrongQuantity, await database.get(DatabaseTag.kanaWrongQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseSpecificWordCorrectQuantity(String wordId) async {
    await database.load(BoxTag.statisticCount);
    final key = DatabaseTag.keySpecificWordCorrectQuantity(wordId);
    const tag = DatabaseTag.specificWordCorrectQuantity;

    final map = (database.get(tag, defaultValue: <String, int>{}) as Map).cast<String, int>();
    map[key] = map.containsKey(key) ? map[key]! + 1 : 1;
    await database.put(tag, map);
  }

  @override
  Future<void> increaseSpecificWordWrongQuantity(String wordId) async {
    await database.load(BoxTag.statisticCount);
    final key = DatabaseTag.keySpecificWordWrongQuantity(wordId);
    const tag = DatabaseTag.specificWordWrongQuantity;

    final map = (database.get(tag, defaultValue: <String, int>{}) as Map).cast<String, int>();
    map[key] = map.containsKey(key) ? map[key]! + 1 : 1;
    await database.put(tag, map);
  }

  @override
  Future<void> increaseSpecificKanaCorrectQuantity(String kanaId) async {
    await database.load(BoxTag.statisticCount);
    final key = DatabaseTag.keySpecificKanaCorrectQuantity(kanaId);
    const tag = DatabaseTag.specificKanaCorrectQuantity;

    final map = (database.get(tag, defaultValue: <String, int>{}) as Map).cast<String, int>();
    map[key] = map.containsKey(key) ? map[key]! + 1 : 1;
    await database.put(tag, map);
  }

  @override
  Future<void> increaseSpecificKanaWrongQuantity(String kanaId) async {
    await database.load(BoxTag.statisticCount);
    final key = DatabaseTag.keySpecificKanaWrongQuantity(kanaId);
    const tag = DatabaseTag.specificKanaWrongQuantity;

    final map = (database.get(tag, defaultValue: <String, int>{}) as Map).cast<String, int>();
    map[key] = map.containsKey(key) ? map[key]! + 1 : 1;
    await database.put(tag, map);
  }

  @override
  Future<void> saveTrainingStats(TrainingStats trainingStats) async {
    await database.load(BoxTag.statisticObjects);
    await database.add(trainingStats);
  }

  @override
  Future<int> bothQuantity() async {
    await database.load(BoxTag.statisticCount);
    return database.get(DatabaseTag.bothQuantity, defaultValue: 0);
  }

  @override
  Future<int> notShowHintQuantity() async {
    await database.load(BoxTag.statisticCount);
    return database.get(DatabaseTag.notShowHintQuantity, defaultValue: 0);
  }

  @override
  Future<int> onlyHiraganaQuantity() async {
    await database.load(BoxTag.statisticCount);
    return database.get(DatabaseTag.onlyHiraganaQuantity, defaultValue: 0);
  }

  @override
  Future<int> onlyKatakanaQuantity() async {
    await database.load(BoxTag.statisticCount);
    return database.get(DatabaseTag.onlyKatakanaQuantity, defaultValue: 0);
  }

  @override
  Future<int> showHintQuantity() async {
    await database.load(BoxTag.statisticCount);
    return database.get(DatabaseTag.showHintQuantity, defaultValue: 0);
  }

  @override
  Future<int> trainingQuantity() async {
    await database.load(BoxTag.statisticCount);
    return database.get(DatabaseTag.trainingQuantity, defaultValue: 0);
  }

  @override
  Future<double> avgWordsPerTraining() async {
    await database.load(BoxTag.statisticObjects);
    return database.values.map((trainingStats) => trainingStats.wordsQuantity).reduce((total, wordQuantity) => total + wordQuantity) /
        database.values.length;
  }

  @override
  Future<Map<String, int>> specificWordCorrectQuantityByWordIds(List<String> wordIds) async {
    await database.load(BoxTag.statisticCount);
    final mapDatabase = (database.get(DatabaseTag.specificWordCorrectQuantity, defaultValue: <String, int>{}) as Map).cast<String, int>();

    return wordIds.fold<Map<String, int>>(<String, int>{}, (mapCounter, wordId) {
      mapCounter[wordId] = mapDatabase[DatabaseTag.keySpecificWordCorrectQuantity(wordId)] ?? 0;
      return mapCounter;
    });
  }

  @override
  Future<Map<String, int>> specificWordWrongQuantityByWordIds(List<String> wordIds) async {
    await database.load(BoxTag.statisticCount);
    final mapDatabase = (database.get(DatabaseTag.specificWordWrongQuantity, defaultValue: <String, int>{}) as Map).cast<String, int>();

    return wordIds.fold<Map<String, int>>(<String, int>{}, (mapCounter, wordId) {
      mapCounter[wordId] = mapDatabase[DatabaseTag.keySpecificWordWrongQuantity(wordId)] ?? 0;
      return mapCounter;
    });
  }

  @override
  Future<Map<String, int>> specificKanaCorrectQuantityByKanaIds(List<String> kanaIds) async {
    await database.load(BoxTag.statisticCount);
    final mapDatabase = (database.get(DatabaseTag.specificKanaCorrectQuantity, defaultValue: <String, int>{}) as Map).cast<String, int>();

    return kanaIds.fold<Map<String, int>>(<String, int>{}, (mapCounter, kanaId) {
      mapCounter[kanaId] = mapDatabase[DatabaseTag.keySpecificKanaCorrectQuantity(kanaId)] ?? 0;
      return mapCounter;
    });
  }

  @override
  Future<Map<String, int>> specificKanaWrongQuantityByKanaIds(List<String> kanaIds) async {
    await database.load(BoxTag.statisticCount);
    final mapDatabase = (database.get(DatabaseTag.specificKanaWrongQuantity, defaultValue: <String, int>{}) as Map).cast<String, int>();

    return kanaIds.fold<Map<String, int>>(<String, int>{}, (mapCounter, kanaId) {
      mapCounter[kanaId] = mapDatabase[DatabaseTag.keySpecificKanaWrongQuantity(kanaId)] ?? 0;
      return mapCounter;
    });
  }

  @override
  Future<List<TrainingStats>> getTrainingStats() async {
    await database.load(BoxTag.statisticObjects);
    return database.values.toList().cast<TrainingStats>();
  }
}
