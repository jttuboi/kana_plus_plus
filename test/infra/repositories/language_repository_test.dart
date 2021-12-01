import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks.dart';

void main() {
  group('LanguageRepository', () {
    final mockDatabase = MockDatabase();
    final repository = LanguageRepository(mockDatabase);

    test('gets language code', () {
      when(() => mockDatabase.load(BoxTag.settings)).thenAnswer((invocation) => Future.value());
      when(() => mockDatabase.get(DatabaseTag.language, defaultValue: Default.languageCode)).thenAnswer((invocation) => Future.value('es'));

      expect(repository.getLanguage(), completion('es'));
      verify(() => mockDatabase.load(BoxTag.settings)).called(1);
    });

    test('puts language code', () async {
      when(() => mockDatabase.load(BoxTag.settings)).thenAnswer((invocation) => Future.value());
      when(() => mockDatabase.put(DatabaseTag.language, 'pt')).thenAnswer((invocation) => Future.value());

      await repository.updateLanguage('pt');

      verify(() => mockDatabase.load(BoxTag.settings)).called(1);
      verify(() => mockDatabase.put(DatabaseTag.language, 'pt')).called(1);
    });
  });
}
