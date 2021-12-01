import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks.dart';

void main() {
  group('QuantityOfWordsRepository', () {
    final mockDatabase = MockDatabase();
    final repository = QuantityOfWordsRepository(mockDatabase);

    test('gets quantity of words', () {
      when(() => mockDatabase.load(BoxTag.settings)).thenAnswer((invocation) => Future.value());
      when(() => mockDatabase.get(DatabaseTag.quantityOfWords, defaultValue: Default.minimumTrainingCards))
          .thenAnswer((invocation) => Future.value(10));

      expect(repository.getQuantityOfWords(), completion(10));
      verify(() => mockDatabase.load(BoxTag.settings)).called(1);
    });

    test('puts quantity of words', () async {
      when(() => mockDatabase.load(BoxTag.settings)).thenAnswer((invocation) => Future.value());
      when(() => mockDatabase.put(DatabaseTag.quantityOfWords, 11)).thenAnswer((invocation) => Future.value());

      await repository.updateQuantityOfWords(11);

      verify(() => mockDatabase.load(BoxTag.settings)).called(1);
      verify(() => mockDatabase.put(DatabaseTag.quantityOfWords, 11)).called(1);
    });
  });
}
