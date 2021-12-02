import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks.dart';

void main() {
  group('WordsRepository', () {
    final storage = MockStorage();
    final repository = WordsRepository();

    when(storage.initialize).thenAnswer((_) => Future.value());
    File.initialize(storage);

    test('fetchs all todos', () {
      when(storage.getAllWords).thenAnswer((_) => words);
      final todos = repository.fetchTodos();

      expect(todos, completion(words));
    });
  });
}

const words = <WordModel>[
  WordModel(id: 'id1', romaji: 'romaji1', kanaType: KanaType.hiragana, imageUrl: 'imageUrl1'),
  WordModel(id: 'id2', romaji: 'romaji2', kanaType: KanaType.katakana, imageUrl: 'imageUrl2'),
  WordModel(id: 'id3', romaji: 'romaji3', kanaType: KanaType.both, imageUrl: 'imageUrl3'),
];
