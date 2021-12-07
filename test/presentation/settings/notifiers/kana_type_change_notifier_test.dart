// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('KanaTypeChangeNotifier', () {
    final mockKanaTypeRepository = MockKanaTypeRepository();

    Future<void> createTickForExecuteFutureInsideConstructor() async {
      await Future.delayed(Duration.zero);
    }

    test('starts properly when persist data is return value', () async {
      when(mockKanaTypeRepository.getKanaType).thenAnswer((_) => Future.value(KanaType.hiragana));
      final kanaTypeChangeNotifier = KanaTypeChangeNotifier(mockKanaTypeRepository);

      await createTickForExecuteFutureInsideConstructor();
      expect(kanaTypeChangeNotifier.data, const KanaTypeViewModel(kanaType: KanaType.hiragana, iconUrl: IconUrl.hiragana));
    });

    test('updates data only', () async {
      when(mockKanaTypeRepository.getKanaType).thenAnswer((_) => Future.value(KanaType.both));
      final kanaTypeChangeNotifier = KanaTypeChangeNotifier(mockKanaTypeRepository, mustPersist: false);
      await createTickForExecuteFutureInsideConstructor();

      kanaTypeChangeNotifier.updateKanaType(KanaType.katakana);

      expect(kanaTypeChangeNotifier.data, const KanaTypeViewModel(kanaType: KanaType.katakana, iconUrl: IconUrl.katakana));
      verifyNever(() => mockKanaTypeRepository.updateKanaType(KanaType.katakana));
    });

    test('updates data and persist', () async {
      when(mockKanaTypeRepository.getKanaType).thenAnswer((_) => Future.value(KanaType.katakana));
      when(() => mockKanaTypeRepository.updateKanaType(KanaType.both)).thenAnswer((_) => Future.value());
      final kanaTypeChangeNotifier = KanaTypeChangeNotifier(mockKanaTypeRepository, mustPersist: true);
      await createTickForExecuteFutureInsideConstructor();

      kanaTypeChangeNotifier.updateKanaType(KanaType.both);

      expect(kanaTypeChangeNotifier.data, const KanaTypeViewModel(kanaType: KanaType.both, iconUrl: IconUrl.both));
      verify(() => mockKanaTypeRepository.updateKanaType(KanaType.both)).called(1);
    });
  });
}
