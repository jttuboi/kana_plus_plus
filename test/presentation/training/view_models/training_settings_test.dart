import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('TrainingSettings', () {
    test('sets properly', () {
      const state = TrainingSettings(
        showHint: false,
        kanaType: KanaType.katakana,
        quantityOfWords: 111,
        languageCode: 'es',
      );

      expect(state.showHint, false);
      expect(state.kanaType, KanaType.katakana);
      expect(state.quantityOfWords, 111);
      expect(state.languageCode, 'es');
    });
  });
}
