import 'package:hive/hive.dart';
import 'package:kwriting/domain/domain.dart';

class StatisticsRepository implements IStatisticsRepository {
  late Box _boxCount;
  late Box _boxObjects;

  Future<void> load() async {
    _boxCount = (Hive.isBoxOpen(BoxTag.statisticCount)) ? Hive.box(BoxTag.statisticCount) : await Hive.openBox(BoxTag.statisticCount);
    _boxObjects = (Hive.isBoxOpen(BoxTag.statisticObjects)) ? Hive.box(BoxTag.statisticObjects) : await Hive.openBox(BoxTag.statisticObjects);
  }

  @override
  Future<void> increaseShowHintQuantity() async {
    await load();
    await _boxCount.put(DatabaseTag.showHintQuantity, await _boxCount.get(DatabaseTag.showHintQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseNotShowHintQuantity() async {
    await load();
    await _boxCount.put(DatabaseTag.notShowHintQuantity, await _boxCount.get(DatabaseTag.notShowHintQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseOnlyHiraganaQuantity() async {
    await load();
    await _boxCount.put(DatabaseTag.onlyHiraganaQuantity, await _boxCount.get(DatabaseTag.onlyHiraganaQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseOnlyKatakanaQuantity() async {
    await load();
    await _boxCount.put(DatabaseTag.onlyKatakanaQuantity, await _boxCount.get(DatabaseTag.onlyKatakanaQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseBothQuantity() async {
    await load();
    await _boxCount.put(DatabaseTag.bothQuantity, await _boxCount.get(DatabaseTag.bothQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseTrainingQuantity() async {
    await load();
    await _boxCount.put(DatabaseTag.trainingQuantity, await _boxCount.get(DatabaseTag.trainingQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseWordCorrectQuantity() async {
    await load();
    await _boxCount.put(DatabaseTag.wordCorrectQuantity, await _boxCount.get(DatabaseTag.wordCorrectQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseWordWrongQuantity() async {
    await load();
    await _boxCount.put(DatabaseTag.wordWrongQuantity, await _boxCount.get(DatabaseTag.wordWrongQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseKanaCorrectQuantity() async {
    await load();
    await _boxCount.put(DatabaseTag.kanaCorrectQuantity, await _boxCount.get(DatabaseTag.kanaCorrectQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseKanaWrongQuantity() async {
    await load();
    await _boxCount.put(DatabaseTag.kanaWrongQuantity, await _boxCount.get(DatabaseTag.kanaWrongQuantity, defaultValue: 0) + 1);
  }

  @override
  Future<void> increaseSpecificWordCorrectQuantity(String wordId) async {
    await load();
    final key = DatabaseTag.keySpecificWordCorrectQuantity(wordId);
    const tag = DatabaseTag.specificWordCorrectQuantity;

    final Map<String, int> map = await _boxCount.get(tag, defaultValue: <String, int>{});
    map[key] = map.containsKey(key) ? map[key]! + 1 : 1;
    await _boxCount.put(tag, map);
  }

  @override
  Future<void> increaseSpecificWordWrongQuantity(String wordId) async {
    await load();
    final key = DatabaseTag.keySpecificWordWrongQuantity(wordId);
    const tag = DatabaseTag.specificWordWrongQuantity;

    final Map<String, int> map = await _boxCount.get(tag, defaultValue: <String, int>{});
    map[key] = map.containsKey(key) ? map[key]! + 1 : 1;
    await _boxCount.put(tag, map);
  }

  @override
  Future<void> increaseSpecificKanaCorrectQuantity(String kanaId) async {
    await load();
    final key = DatabaseTag.keySpecificKanaCorrectQuantity(kanaId);
    const tag = DatabaseTag.specificKanaCorrectQuantity;

    final Map<String, int> map = await _boxCount.get(tag, defaultValue: <String, int>{});
    map[key] = map.containsKey(key) ? map[key]! + 1 : 1;
    await _boxCount.put(tag, map);
  }

  @override
  Future<void> increaseSpecificKanaWrongQuantity(String kanaId) async {
    await load();
    final key = DatabaseTag.keySpecificKanaWrongQuantity(kanaId);
    const tag = DatabaseTag.specificKanaWrongQuantity;

    final Map<String, int> map = await _boxCount.get(tag, defaultValue: <String, int>{});
    map[key] = map.containsKey(key) ? map[key]! + 1 : 1;
    await _boxCount.put(tag, map);
  }

  @override
  Future<void> saveTrainingStats(TrainingStats trainingStats) async {
    await load();
    await _boxObjects.add(trainingStats);
  }

  @override
  Future<int> bothQuantity() async {
    await load();
    return _boxCount.get(DatabaseTag.bothQuantity, defaultValue: 0);
  }

  @override
  Future<int> notShowHintQuantity() async {
    await load();
    return _boxCount.get(DatabaseTag.notShowHintQuantity, defaultValue: 0);
  }

  @override
  Future<int> onlyHiraganaQuantity() async {
    await load();
    return _boxCount.get(DatabaseTag.onlyHiraganaQuantity, defaultValue: 0);
  }

  @override
  Future<int> onlyKatakanaQuantity() async {
    await load();
    return _boxCount.get(DatabaseTag.onlyKatakanaQuantity, defaultValue: 0);
  }

  @override
  Future<int> showHintQuantity() async {
    await load();
    return _boxCount.get(DatabaseTag.showHintQuantity, defaultValue: 0);
  }

  @override
  Future<int> trainingQuantity() async {
    await load();
    return _boxCount.get(DatabaseTag.trainingQuantity, defaultValue: 0);
  }

  @override
  Future<double> avgWordsPerTraining() async {
    await load();
    return _boxObjects.values.map((trainingStats) => trainingStats.wordsQuantity).reduce((total, wordQuantity) => total + wordQuantity) /
        _boxObjects.values.length;
  }

  @override
  Future<int> specificWordCorrectQuantity(String wordId) async {
    await load();
    final key = DatabaseTag.keySpecificWordCorrectQuantity(wordId);
    const tag = DatabaseTag.specificWordCorrectQuantity;

    final Map<String, int> map = await _boxCount.get(tag, defaultValue: <String, int>{});
    return map.containsKey(key) ? map[key]! : 0;
  }

  @override
  Future<int> specificWordWrongQuantity(String wordId) async {
    await load();

    final key = DatabaseTag.keySpecificWordWrongQuantity(wordId);
    const tag = DatabaseTag.specificWordWrongQuantity;

    final Map<String, int> map = await _boxCount.get(tag, defaultValue: <String, int>{});
    return map.containsKey(key) ? map[key]! : 0;
  }

  @override
  Future<int> specificKanaCorrectQuantity(String kanaId) async {
    await load();
    final key = DatabaseTag.keySpecificKanaCorrectQuantity(kanaId);
    const tag = DatabaseTag.specificKanaCorrectQuantity;

    final Map<String, int> map = await _boxCount.get(tag, defaultValue: <String, int>{});
    return map.containsKey(key) ? map[key]! : 0;
  }

  @override
  Future<int> specificKanaWrongQuantity(String kanaId) async {
    await load();
    final key = DatabaseTag.keySpecificKanaWrongQuantity(kanaId);
    const tag = DatabaseTag.specificKanaWrongQuantity;

    final Map<String, int> map = await _boxCount.get(tag, defaultValue: <String, int>{});
    return map.containsKey(key) ? map[key]! : 0;
  }

  @override
  Future<List<TrainingStats>> getTrainingStats() async {
    await load();
    return _boxObjects.values.toList() as List<TrainingStats>;
  }
}
