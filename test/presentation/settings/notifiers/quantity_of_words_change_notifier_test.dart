// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('QuantityOfWordsChangeNotifier', () {
    final mockQuantityOfWordsRepository = MockQuantityOfWordsRepository();

    Future<void> createTickForExecuteFutureInsideConstructor() async {
      await Future.delayed(Duration.zero);
    }

    test('starts properly when persist data is true', () async {
      when(mockQuantityOfWordsRepository.getQuantityOfWords).thenAnswer((_) => Future.value(10));
      final quantityOfWordsChangeNotifier = QuantityOfWordsChangeNotifier(mockQuantityOfWordsRepository);

      await createTickForExecuteFutureInsideConstructor();
      expect(quantityOfWordsChangeNotifier.quantity, 10);
    });

    test('updates quantity only', () async {
      when(mockQuantityOfWordsRepository.getQuantityOfWords).thenAnswer((_) => Future.value(10));
      final quantityOfWordsChangeNotifier = QuantityOfWordsChangeNotifier(mockQuantityOfWordsRepository, mustPersist: false);
      await createTickForExecuteFutureInsideConstructor();

      quantityOfWordsChangeNotifier.updateQuantity(12);

      expect(quantityOfWordsChangeNotifier.quantity, 12);
      verifyNever(() => mockQuantityOfWordsRepository.updateQuantityOfWords(12));
    });

    test('updates quantity and persist', () async {
      when(mockQuantityOfWordsRepository.getQuantityOfWords).thenAnswer((_) => Future.value(10));
      when(() => mockQuantityOfWordsRepository.updateQuantityOfWords(12)).thenAnswer((_) => Future.value());
      final quantityOfWordsChangeNotifier = QuantityOfWordsChangeNotifier(mockQuantityOfWordsRepository, mustPersist: true);
      await createTickForExecuteFutureInsideConstructor();

      quantityOfWordsChangeNotifier.updateQuantity(12);

      expect(quantityOfWordsChangeNotifier.quantity, 12);
      verify(() => mockQuantityOfWordsRepository.updateQuantityOfWords(12)).called(1);
    });
  });
}
