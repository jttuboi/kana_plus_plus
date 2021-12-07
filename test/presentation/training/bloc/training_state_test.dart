import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('TrainingInitial', () {
    test('sets properly', () {
      const state = TrainingInitial();

      expect(state, const TrainingInitial());
    });
  });

  group('TrainingReady', () {
    test('sets properly', () {
      const state = TrainingReady();

      expect(state, const TrainingReady());
    });
  });
}
