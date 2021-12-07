import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks.dart';

void main() {
  group('ShowHintRepository', () {
    final mockDatabase = MockDatabase();
    final repository = ShowHintRepository(mockDatabase);

    test('gets show hint', () {
      when(() => mockDatabase.load(BoxTag.settings)).thenAnswer((_) => Future.value());
      when(() => mockDatabase.get(DatabaseTag.showHint, defaultValue: Default.showHint)).thenAnswer((_) => Future.value(true));

      expect(repository.getShowHint(), completion(true));
      verify(() => mockDatabase.load(BoxTag.settings)).called(1);
    });

    test('puts show hint', () async {
      when(() => mockDatabase.load(BoxTag.settings)).thenAnswer((_) => Future.value());
      when(() => mockDatabase.put(DatabaseTag.showHint, false)).thenAnswer((_) => Future.value());

      await repository.updateShowHint(false);

      verify(() => mockDatabase.load(BoxTag.settings)).called(1);
      verify(() => mockDatabase.put(DatabaseTag.showHint, false)).called(1);
    });
  });
}
