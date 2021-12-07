import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks.dart';

void main() {
  group('AppRepository', () {
    final mockDatabase = MockDatabase();
    final repository = AppRepository(mockDatabase);

    test('gets first time', () {
      when(() => mockDatabase.load(BoxTag.app)).thenAnswer((_) => Future.value());
      when(() => mockDatabase.get(DatabaseTag.firstTime, defaultValue: Default.firstTime)).thenAnswer((_) => Future.value(true));

      expect(repository.isFirstTime(), completion(isTrue));
      verify(() => mockDatabase.load(BoxTag.app)).called(1);
    });

    test('puts first time', () async {
      when(() => mockDatabase.load(BoxTag.app)).thenAnswer((_) => Future.value());
      when(() => mockDatabase.put(DatabaseTag.firstTime, true)).thenAnswer((_) => Future.value());

      await repository.setFirstTime(true);

      verify(() => mockDatabase.load(BoxTag.app)).called(1);
      verify(() => mockDatabase.put(DatabaseTag.firstTime, true)).called(1);
    });
  });
}
