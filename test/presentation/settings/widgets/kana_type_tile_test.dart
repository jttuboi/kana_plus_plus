import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../utils/mocks.dart';

void main() {
  group('KanaTypeTile', () {
    final mockKanaTypeChangeNotifier = MockKanaTypeChangeNotifier();

    Future<void> pumpKanaTypeTile(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<KanaTypeChangeNotifier>(
            create: (context) => mockKanaTypeChangeNotifier,
            child: const Material(child: KanaTypeTile()),
          ),
          localizationsDelegates: JStrings.localizationsDelegates,
          supportedLocales: JStrings.supportedLocales,
        ),
      );
    }

    testWidgets('renders correctly with hiragana', (tester) async {
      when(() => mockKanaTypeChangeNotifier.data).thenReturn(const KanaTypeViewModel(kanaType: KanaType.hiragana, iconUrl: IconUrl.hiragana));

      await pumpKanaTypeTile(tester);
      final strings = JStrings.of(tester.element(find.byType(KanaTypeTile)))!;

      expect(find.text(strings.settingsKanaType), findsOneWidget);
      expect(find.text(strings.settingsOnlyHiragana), findsOneWidget);
      expect(find.byType(DefaultTile), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('renders correctly with katakana', (tester) async {
      when(() => mockKanaTypeChangeNotifier.data).thenReturn(const KanaTypeViewModel(kanaType: KanaType.katakana, iconUrl: IconUrl.katakana));

      await pumpKanaTypeTile(tester);
      final strings = JStrings.of(tester.element(find.byType(KanaTypeTile)))!;

      expect(find.text(strings.settingsKanaType), findsOneWidget);
      expect(find.text(strings.settingsOnlyKatakana), findsOneWidget);
      expect(find.byType(DefaultTile), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    testWidgets('renders correctly with both', (tester) async {
      when(() => mockKanaTypeChangeNotifier.data).thenReturn(const KanaTypeViewModel(kanaType: KanaType.both, iconUrl: IconUrl.both));

      await pumpKanaTypeTile(tester);
      final strings = JStrings.of(tester.element(find.byType(KanaTypeTile)))!;

      expect(find.text(strings.settingsKanaType), findsOneWidget);
      expect(find.text(strings.settingsOnlyHiraganaKatakana), findsOneWidget);
      expect(find.byType(DefaultTile), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
