import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

import '../../../utils/utils.dart';

void main() {
  group('RomajiViewer', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Material(
          child: ReviewTile(
            wordResult: WordViewModel(
              id: 'word id',
              imageUrl: ImageUrl.empty,
              translate: 'translate',
              kanas: [
                KanaViewModel(id: 'id', status: KanaViewerStatus.correct, kanaType: KanaType.hiragana, romaji: 'romaji', strokes: []),
                KanaViewModel(id: 'id', status: KanaViewerStatus.correct, kanaType: KanaType.hiragana, romaji: 'romaji', strokes: []),
              ],
            ),
          ),
        ),
      ));

      tester
        ..expectWidget<ListTile>()
        ..expectSvgPicture(ImageUrl.empty, indexInWidgets: 0)
        ..expectText('word id')
        ..expectWidget<ListView>()
        ..expectWidget<ReviewKanaContent>(widgetQuantityExpected: 2);
    });
  });
}
