import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

void main() {
  group('KanaInitial', () {
    test('sets properly', () {
      const state = KanaInitial();

      expect(state, const KanaInitial());
    });
  });

  group('KanaReady', () {
    test('sets properly', () {
      const state = KanaReady(
        index: 5,
        total: 10,
        kanas: [
          KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
        ],
      );

      expect(state.index, 5);
      expect(state.total, 10);
      expect(state.kanas, const [
        KanaViewModel(id: 'id 2', status: KanaViewerStatus.normal, kanaType: KanaType.both, romaji: 'romaji 2', strokes: ['strokes 2'])
      ]);
    });
  });
}
