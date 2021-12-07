import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../../utils/mocks.dart';

void main() {
  group('ShowHintTile', () {
    final mockShowHintChangeNotifier = MockShowHintChangeNotifier();
    testWidgets('renders correctly', (tester) async {
      when(() => mockShowHintChangeNotifier.data).thenReturn(ShowHintViewModel.empty);

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<ShowHintChangeNotifier>(
            create: (context) => mockShowHintChangeNotifier,
            child: const Material(child: ShowHintTile()),
          ),
          localizationsDelegates: JStrings.localizationsDelegates,
          supportedLocales: JStrings.supportedLocales,
        ),
      );
      final strings = JStrings.of(tester.element(find.byType(ShowHintTile)))!;

      expect(find.text(strings.settingsShowHint), findsOneWidget);
      expect(find.byType(SwitchListTile), findsOneWidget);
      expect(find.byType(SvgPicture), findsOneWidget);
    });
  });
}
