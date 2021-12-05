import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/widgets/kana_details.dart';
import 'package:kwriting/presentation/words/words.dart';

void main() {
  group('KanasDetails', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: KanasDetails(
          kanas: [
            KanaViewModel(id: 'id', kanaType: KanaType.both, romaji: 'romaji', strokes: [], correctCount: 1, wrongCount: 1),
            KanaViewModel(id: 'id', kanaType: KanaType.both, romaji: 'romaji', strokes: [], correctCount: 1, wrongCount: 1),
            KanaViewModel(id: 'id', kanaType: KanaType.both, romaji: 'romaji', strokes: [], correctCount: 1, wrongCount: 1),
          ],
        ),
      ));

      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.byType(LayoutBuilder), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(KanaDetail), findsNWidgets(3));
    });
  });
}
