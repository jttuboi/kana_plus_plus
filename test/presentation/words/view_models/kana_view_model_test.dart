import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';

void main() {
  group('KanaViewModel', () {
    test('renders correctly', () {
      const viewModel = KanaViewModel(
        id: 'id 2',
        kanaType: KanaType.katakana,
        romaji: 'romaji 2',
        strokes: ['strokes 1', 'strokes 2'],
        correctCount: 1,
        wrongCount: 2,
      );

      expect(viewModel.id, 'id 2');
      expect(viewModel.kanaType, KanaType.katakana);
      expect(viewModel.romaji, 'romaji 2');
      expect(viewModel.strokes, ['strokes 1', 'strokes 2']);
      expect(viewModel.correctCount, 1);
      expect(viewModel.wrongCount, 2);
    });

    test('gets KanaViewModel from KanaModel', () {
      final viewModel = KanaViewModel.fromKanaModel(
        const KanaModel(
          id: 'あ',
          kanaType: KanaType.katakana,
          romaji: 'a',
          strokes: ['stroke a'],
        ),
        correctKanaCount: const {'あ': 2},
        wrongKanaCount: const {'あ': 1},
      );

      expect(
        viewModel,
        const KanaViewModel(
          id: 'あ',
          kanaType: KanaType.katakana,
          romaji: 'a',
          strokes: ['stroke a'],
          correctCount: 2,
          wrongCount: 1,
        ),
      );
    });
  });
}
