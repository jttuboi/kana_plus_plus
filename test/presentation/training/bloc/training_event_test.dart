import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('TrainingStarted', () {
    test('sets properly', () {
      const state = TrainingStarted();

      expect(state, const TrainingStarted());
    });
  });
}
