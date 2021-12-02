import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/mocks.dart';

void main() {
  group('KanaTypeRepository', () {
    final mockDatabase = MockDatabase();
    final repository = KanaTypeRepository(mockDatabase);

    test('gets kana type', () {
      when(() => mockDatabase.load(BoxTag.settings)).thenAnswer((inv_ocation) => Future.value());
      when(() => mockDatabase.get(DatabaseTag.kanaType, defaultValue: KanaType.both)).thenAnswer((_) => Future.value(KanaType.hiragana));

      expect(repository.getKanaType(), completion(KanaType.hiragana));
      verify(() => mockDatabase.load(BoxTag.settings)).called(1);
    });

    test('puts kana type', () async {
      when(() => mockDatabase.load(BoxTag.settings)).thenAnswer((_) => Future.value());
      when(() => mockDatabase.put(DatabaseTag.kanaType, KanaType.katakana)).thenAnswer((_) => Future.value());

      await repository.updateKanaType(KanaType.katakana);

      verify(() => mockDatabase.load(BoxTag.settings)).called(1);
      verify(() => mockDatabase.put(DatabaseTag.kanaType, KanaType.katakana)).called(1);
    });
  });
}
