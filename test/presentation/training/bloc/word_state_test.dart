import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('WordInitial', () {
    test('sets properly', () {
      const state = WordInitial();

      expect(state, const WordInitial());
    });
  });

  group('WordReady', () {
    test('sets properly', () {
      const state = WordReady(
        index: 10,
        total: 30,
        translate: 'translate 10',
        imageUrl: 'image url 10',
      );

      expect(state.index, 10);
      expect(state.total, 30);
      expect(state.translate, 'translate 10');
      expect(state.imageUrl, 'image url 10');
    });
  });
}
