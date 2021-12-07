import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

import '../../../utils/utils.dart';

void main() {
  group('KanaViewer', () {
    testWidgets('renders correctly when status = select', (tester) async {
      const kanaViewModel = KanaViewModel(id: 'あ', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'A', strokes: []);
      await tester.pumpWidget(const MaterialApp(
        home: KanaViewer(kanaViewModel, squareSize: 100),
      ));

      tester.expectWidget<KanaViewerSelectRomaji>();
    });

    testWidgets('renders correctly when status = normal', (tester) async {
      const kanaViewModel = KanaViewModel(id: 'あ', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'A', strokes: []);
      await tester.pumpWidget(const MaterialApp(
        home: KanaViewer(kanaViewModel, squareSize: 100),
      ));

      tester.expectWidget<KanaViewerRomaji>();
    });

    testWidgets('renders correctly when status = correct', (tester) async {
      const kanaViewModel = KanaViewModel(id: 'あ', status: KanaViewerStatus.correct, kanaType: KanaType.hiragana, romaji: 'A', strokes: []);
      await tester.pumpWidget(const MaterialApp(
        home: KanaViewer(kanaViewModel, squareSize: 100),
      ));

      tester.expectWidget<KanaViewerKana>();
    });

    testWidgets('renders correctly when status = wrong', (tester) async {
      const kanaViewModel = KanaViewModel(id: 'あ', status: KanaViewerStatus.wrong, kanaType: KanaType.hiragana, romaji: 'A', strokes: []);
      await tester.pumpWidget(const MaterialApp(
        home: KanaViewer(kanaViewModel, squareSize: 100),
      ));

      tester.expectWidget<KanaViewerKana>();
    });
  });

  group('KanaViewerSelectRomaji', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: KanaViewerSelectRomaji(
          romaji: 'A',
          size: 100,
          borderSize: 8,
        ),
      ));

      tester
        ..expectWidget<Transform>()
        ..expectWidget<ClipRect>()
        ..expectWidget<BackdropFilter>()
        ..expectCustomPaintWith<BorderPainter>()
        ..expectWidget<RomajiViewer>(widgetQuantityExpected: 2);
    });
  });

  group('KanaViewerRomaji', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: KanaViewerRomaji(
          romaji: 'A',
          size: 100,
          borderSize: 8,
        ),
      ));

      tester
        ..expectCustomPaintWith<BorderPainter>()
        ..expectWidget<RomajiViewer>();
    });
  });

  group('KanaViewerKana', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: KanaViewerKana(
          strokes: ['M 66.87 26.75 C 68.2729 27.6427 69.8058 29.0247 71.2034 30.5786 C 72.5455 32.0708 73.7627 33.7216 74.62 35.25'],
          userStrokes: [
            [Offset.zero]
          ],
          correct: true,
          size: 100,
          borderSize: 8,
        ),
      ));

      tester
        ..expectCustomPaintWith<BorderPainter>()
        ..expectCustomPaintWith<KanaPainter>()
        ..expectCustomPaintWith<UserKanaPainter>();
    });
  });
}
