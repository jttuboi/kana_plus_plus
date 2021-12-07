import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

import '../../../utils/utils.dart';

void main() {
  group('RomajiViewer', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ReviewKanaContent(
          kanaResult: KanaViewModel(
            id: 'a',
            status: KanaViewerStatus.correct,
            kanaType: KanaType.hiragana,
            romaji: 'romaji',
            strokes: ['strokes'],
            userStrokes: [
              [Offset(1, 1)]
            ],
          ),
        ),
      ));

      tester
        ..expectCustomPaintWith<BorderPainter>()
        ..expectCustomPaintWith<UserKanaPainter>();
    });
  });
}
