import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';

void main() {
  group('SelectionOptionPage', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: SelectionOptionPage.routeName,
        onGenerateRoute: (settings) {
          if (settings.name == SelectionOptionPage.routeName) {
            return SelectionOptionPage.route(SelectionOptionArgs(
              title: 'title',
              bannerUrl: ImageUrl.empty,
              selectedOptionKey: 'option1',
              options: const [
                SelectionOptionItem(key: 'option1', label: 'option 1'),
                SelectionOptionItem(key: 'option2', label: 'option 2'),
              ],
              onSelected: (value) {},
            ));
          }
        },
      ));

      expect(find.byType(WillPopScope), findsOneWidget);
      expect(find.byType(FlexibleScaffold), findsOneWidget);
      expect(find.byType(SliverFillRemaining), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('option 1'), findsOneWidget);
      expect(find.text('option 2'), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
      expect(find.byType(SvgPicture), findsNWidgets(2));
    });

    testWidgets('renders correctly with icons', (tester) async {
      await tester.pumpWidget(MaterialApp(
        initialRoute: SelectionOptionPage.routeName,
        onGenerateRoute: (settings) {
          if (settings.name == SelectionOptionPage.routeName) {
            return SelectionOptionPage.route(SelectionOptionArgs(
              title: 'title',
              bannerUrl: ImageUrl.empty,
              selectedOptionKey: 'option1',
              options: const [
                SelectionOptionItem(key: 'option1', label: 'option 1', iconUrl: IconUrl.empty),
                SelectionOptionItem(key: 'option2', label: 'option 2', iconUrl: IconUrl.empty),
              ],
              onSelected: (value) {},
            ));
          }
        },
      ));

      expect(find.byType(WillPopScope), findsOneWidget);
      expect(find.byType(FlexibleScaffold), findsOneWidget);
      expect(find.byType(SliverFillRemaining), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('option 1'), findsOneWidget);
      expect(find.text('option 2'), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
      expect(find.byType(SvgPicture), findsNWidgets(4));
    });
  });
}
