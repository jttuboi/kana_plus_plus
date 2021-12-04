import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../utils/mocks.dart';

void main() {
  group('QuantityOfWordsTile', () {
    final mockQuantityOfWordsChangeNotifier = MockQuantityOfWordsChangeNotifier();

    testWidgets('renders correctly', (tester) async {
      when(() => mockQuantityOfWordsChangeNotifier.quantity).thenReturn(11);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<QuantityOfWordsChangeNotifier>(
            create: (context) => mockQuantityOfWordsChangeNotifier,
            child: const Material(child: QuantityOfWordsTile()),
          ),
          localizationsDelegates: JStrings.localizationsDelegates,
          supportedLocales: JStrings.supportedLocales,
        ),
      );
      final strings = JStrings.of(tester.element(find.byType(QuantityOfWordsTile)))!;

      expect(find.text(strings.settingsQuantityOfWords), findsOneWidget);
      expect(find.byType(ListTile), findsOneWidget);
      expect(find.byType(SliderTheme), findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });

    Future<void> swipeToRight(WidgetTester tester) async {
      final topLeft = tester.getTopLeft(find.byType(Slider));
      final bottomRight = tester.getBottomRight(find.byType(Slider));

      await tester.pump(kLongPressTimeout + kPressTimeout);

      final target = topLeft + (bottomRight - topLeft) / 4.0;
      await tester.tapAt(target);
      await tester.pumpAndSettle();
    }

    testWidgets('updates quantity when slider changed', (tester) async {
      when(() => mockQuantityOfWordsChangeNotifier.updateQuantity(9)).thenReturn(null);
      when(() => mockQuantityOfWordsChangeNotifier.quantity).thenReturn(11);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<QuantityOfWordsChangeNotifier>(
            create: (context) => mockQuantityOfWordsChangeNotifier,
            child: const Material(child: QuantityOfWordsTile()),
          ),
          localizationsDelegates: JStrings.localizationsDelegates,
          supportedLocales: JStrings.supportedLocales,
        ),
      );

      await swipeToRight(tester);

      verify(() => mockQuantityOfWordsChangeNotifier.updateQuantity(9)).called(1);
    });
  });
}
