// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('ShowHintChangeNotifier', () {
    final mockShowHintRepository = MockShowHintRepository();

    Future<void> createTickForExecuteFutureInsideConstructor() async {
      await Future.delayed(Duration.zero);
    }

    test('starts properly when persist data is true', () async {
      when(mockShowHintRepository.getShowHint).thenAnswer((_) => Future.value(true));
      final showHintChangeNotifier = ShowHintChangeNotifier(mockShowHintRepository);

      await createTickForExecuteFutureInsideConstructor();
      expect(showHintChangeNotifier.data, const ShowHintViewModel(showHint: true, iconUrl: IconUrl.showHint));
    });

    test('starts properly when persist data is false', () async {
      when(mockShowHintRepository.getShowHint).thenAnswer((_) => Future.value(false));
      final showHintChangeNotifier = ShowHintChangeNotifier(mockShowHintRepository);

      await createTickForExecuteFutureInsideConstructor();
      expect(showHintChangeNotifier.data, const ShowHintViewModel(showHint: false, iconUrl: IconUrl.notShowHint));
    });

    test('updates show hint data only', () async {
      when(mockShowHintRepository.getShowHint).thenAnswer((_) => Future.value(false));
      final showHintChangeNotifier = ShowHintChangeNotifier(mockShowHintRepository, mustPersist: false);
      await createTickForExecuteFutureInsideConstructor();

      showHintChangeNotifier.updateShowHint(true);

      expect(showHintChangeNotifier.data, const ShowHintViewModel(showHint: true, iconUrl: IconUrl.showHint));
      verifyNever(() => mockShowHintRepository.updateShowHint(true));
    });

    test('updates show hint data and persist', () async {
      when(mockShowHintRepository.getShowHint).thenAnswer((_) => Future.value(false));
      when(() => mockShowHintRepository.updateShowHint(true)).thenAnswer((_) => Future.value());
      final showHintChangeNotifier = ShowHintChangeNotifier(mockShowHintRepository, mustPersist: true);
      await createTickForExecuteFutureInsideConstructor();

      showHintChangeNotifier.updateShowHint(true);

      expect(showHintChangeNotifier.data, const ShowHintViewModel(showHint: true, iconUrl: IconUrl.showHint));
      verify(() => mockShowHintRepository.updateShowHint(true)).called(1);
    });
  });
}
