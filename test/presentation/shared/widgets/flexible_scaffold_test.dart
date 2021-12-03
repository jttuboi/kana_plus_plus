// ignore_for_file: avoid_redundant_argument_values

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';

void main() {
  group('FlexibleScaffold', () {
    testWidgets('renders without tabs, without flexible, without actions', (tester) async {
      final sliverContentKey = GlobalKey();
      await tester.pumpWidget(MaterialApp(
        home: FlexibleScaffold(
          title: 'title',
          bannerUrl: ImageUrl.empty,
          onBackButtonPressed: () {},
          isFlexible: false,
          sliverContent: SliverFillRemaining(key: sliverContentKey),
        ),
      ));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);

      // check icon back button
      expect(find.ancestor(of: find.byType(SliverAppBar), matching: find.byType(CustomScrollView)), findsOneWidget);
      expect(find.ancestor(of: find.byType(IconButton), matching: find.byType(SliverAppBar)), findsOneWidget);
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(IconButton)), findsOneWidget);

      // check flexibleSpace when fixed
      expect(find.ancestor(of: find.byType(FlexibleSpaceBar), matching: find.byType(SliverAppBar)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Padding), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(2));
      expect(find.ancestor(of: find.byType(FittedBox), matching: find.byType(Padding)), findsNWidgets(2));
      expect(find.ancestor(of: find.text('title'), matching: find.byType(FittedBox)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Container), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(Container)), findsOneWidget);

      // check sliverContent (external value)
      expect(find.ancestor(of: find.byKey(sliverContentKey), matching: find.byType(CustomScrollView)), findsOneWidget);
    });

    testWidgets('renders without tabs, without flexible, with actions', (tester) async {
      final sliverContentKey = GlobalKey();
      await tester.pumpWidget(MaterialApp(
        home: FlexibleScaffold(
          title: 'title',
          bannerUrl: ImageUrl.empty,
          onBackButtonPressed: () {},
          isFlexible: false,
          sliverContent: SliverFillRemaining(key: sliverContentKey),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.lightbulb)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.accessibility)),
          ],
        ),
      ));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);

      // check icon back button
      expect(find.ancestor(of: find.byType(SliverAppBar), matching: find.byType(CustomScrollView)), findsOneWidget);
      expect(find.ancestor(of: find.byType(IconButton), matching: find.byType(SliverAppBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(IconButton)), findsOneWidget);

      // check flexibleSpace when fixed
      expect(find.ancestor(of: find.byType(FlexibleSpaceBar), matching: find.byType(SliverAppBar)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Padding), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(2));
      expect(find.ancestor(of: find.byType(FittedBox), matching: find.byType(Padding)), findsNWidgets(2));
      expect(find.ancestor(of: find.text('title'), matching: find.byType(FittedBox)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Container), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(Container)), findsOneWidget);

      // check sliverContent (external value)
      expect(find.ancestor(of: find.byKey(sliverContentKey), matching: find.byType(CustomScrollView)), findsOneWidget);

      // check actions
      expect(find.byIcon(Icons.lightbulb), findsOneWidget);
      expect(find.byIcon(Icons.accessibility), findsOneWidget);
    });

    testWidgets('renders without tabs, with flexible, without actions', (tester) async {
      final sliverContentKey = GlobalKey();
      await tester.pumpWidget(MaterialApp(
        home: FlexibleScaffold(
          title: 'title',
          bannerUrl: ImageUrl.empty,
          onBackButtonPressed: () {},
          isFlexible: true,
          sliverContent: SliverFillRemaining(key: sliverContentKey),
        ),
      ));

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);

      // check icon back button
      expect(find.ancestor(of: find.byType(SliverAppBar), matching: find.byType(CustomScrollView)), findsOneWidget);
      expect(find.ancestor(of: find.byType(IconButton), matching: find.byType(SliverAppBar)), findsOneWidget);
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(IconButton)), findsOneWidget);

      // check flexibleSpace when fixed
      expect(find.ancestor(of: find.byType(LayoutBuilder), matching: find.byType(SliverAppBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(FlexibleSpaceBar), matching: find.byType(LayoutBuilder)), findsNWidgets(2));
      expect(find.ancestor(of: find.byType(Padding), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(2));
      expect(find.ancestor(of: find.byType(FittedBox), matching: find.byType(Padding)), findsNWidgets(2));
      expect(find.ancestor(of: find.text('title'), matching: find.byType(FittedBox)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Container), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(Container)), findsOneWidget);

      // check sliverContent (external value)
      expect(find.ancestor(of: find.byKey(sliverContentKey), matching: find.byType(CustomScrollView)), findsOneWidget);
    });

    testWidgets('renders with tabs 1, without flexible, without actions', (tester) async {
      final sliverContentKey1 = GlobalKey();
      final sliverContentKey2 = GlobalKey();
      await tester.pumpWidget(MaterialApp(
        home: FlexibleScaffold(
          title: 'title',
          bannerUrl: ImageUrl.empty,
          onBackButtonPressed: () {},
          isFlexible: false,
          tabs: const [Tab(text: 'tab1'), Tab(text: 'tab2')],
          sliverContent: TabBarView(
            children: [Container(key: sliverContentKey1), Container(key: sliverContentKey2)],
          ),
        ),
      ));

      expect(find.byType(DefaultTabController), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(NestedScrollView), findsOneWidget);

      // check icon back button
      expect(find.ancestor(of: find.byType(SliverAppBar), matching: find.byType(NestedScrollView)), findsOneWidget);
      expect(find.ancestor(of: find.byType(IconButton), matching: find.byType(SliverAppBar)), findsOneWidget);
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(IconButton)), findsOneWidget);

      // check flexibleSpace when fixed
      expect(find.ancestor(of: find.byType(FlexibleSpaceBar), matching: find.byType(SliverAppBar)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Padding), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(2));
      expect(find.ancestor(of: find.byType(FittedBox), matching: find.byType(Padding)), findsNWidgets(2));
      expect(find.ancestor(of: find.text('title'), matching: find.byType(FittedBox)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Container), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(Container)), findsOneWidget);

      // check tabs (external value)
      expect(find.text('tab1'), findsOneWidget);
      expect(find.text('tab2'), findsOneWidget);

      // check sliverContent (external value)
      expect(find.byType(TabBarView), findsOneWidget);
      expect(find.byKey(sliverContentKey1), findsOneWidget);
    });

    testWidgets('renders with tabs 2, without flexible, without actions', (tester) async {
      final sliverContentKey1 = GlobalKey();
      final sliverContentKey2 = GlobalKey();
      await tester.pumpWidget(MaterialApp(
        home: FlexibleScaffold(
          title: 'title',
          bannerUrl: ImageUrl.empty,
          onBackButtonPressed: () {},
          isFlexible: false,
          tabs: const [Tab(text: 'tab1'), Tab(text: 'tab2')],
          sliverContent: TabBarView(
            children: [Container(key: sliverContentKey1), Container(key: sliverContentKey2)],
          ),
        ),
      ));

      expect(find.byType(DefaultTabController), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(NestedScrollView), findsOneWidget);

      // check icon back button
      expect(find.ancestor(of: find.byType(SliverAppBar), matching: find.byType(NestedScrollView)), findsOneWidget);
      expect(find.ancestor(of: find.byType(IconButton), matching: find.byType(SliverAppBar)), findsOneWidget);
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(IconButton)), findsOneWidget);

      // check flexibleSpace when fixed
      expect(find.ancestor(of: find.byType(FlexibleSpaceBar), matching: find.byType(SliverAppBar)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Padding), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(2));
      expect(find.ancestor(of: find.byType(FittedBox), matching: find.byType(Padding)), findsNWidgets(2));
      expect(find.ancestor(of: find.text('title'), matching: find.byType(FittedBox)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Container), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(Container)), findsOneWidget);

      // check tabs (external value)
      expect(find.text('tab1'), findsOneWidget);
      expect(find.text('tab2'), findsOneWidget);

      await tester.tap(find.text('tab2'));
      await tester.pumpAndSettle();

      // check sliverContent (external value)
      expect(find.byType(TabBarView), findsOneWidget);
      expect(find.byKey(sliverContentKey2), findsOneWidget);
    });

    testWidgets('renders with tabs, without flexible, with actions', (tester) async {
      final sliverContentKey1 = GlobalKey();
      final sliverContentKey2 = GlobalKey();
      await tester.pumpWidget(MaterialApp(
        home: FlexibleScaffold(
          title: 'title',
          bannerUrl: ImageUrl.empty,
          onBackButtonPressed: () {},
          isFlexible: false,
          tabs: const [Tab(text: 'tab1'), Tab(text: 'tab2')],
          sliverContent: TabBarView(
            children: [Container(key: sliverContentKey1), Container(key: sliverContentKey2)],
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.lightbulb)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.accessibility)),
          ],
        ),
      ));

      expect(find.byType(DefaultTabController), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(NestedScrollView), findsOneWidget);

      // check icon back button
      expect(find.ancestor(of: find.byType(SliverAppBar), matching: find.byType(NestedScrollView)), findsOneWidget);
      expect(find.ancestor(of: find.byType(IconButton), matching: find.byType(SliverAppBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(IconButton)), findsOneWidget);

      // check flexibleSpace when fixed
      expect(find.ancestor(of: find.byType(FlexibleSpaceBar), matching: find.byType(SliverAppBar)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Padding), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(2));
      expect(find.ancestor(of: find.byType(FittedBox), matching: find.byType(Padding)), findsNWidgets(2));
      expect(find.ancestor(of: find.text('title'), matching: find.byType(FittedBox)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Container), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(Container)), findsOneWidget);

      // check actions
      expect(find.byIcon(Icons.lightbulb), findsOneWidget);
      expect(find.byIcon(Icons.accessibility), findsOneWidget);

      // check tabs (external value)
      expect(find.text('tab1'), findsOneWidget);
      expect(find.text('tab2'), findsOneWidget);

      // check sliverContent (external value)
      expect(find.byType(TabBarView), findsOneWidget);
      expect(find.byKey(sliverContentKey1), findsOneWidget);
    });

    testWidgets('renders with tabs, with flexible, without actions', (tester) async {
      final sliverContentKey1 = GlobalKey();
      final sliverContentKey2 = GlobalKey();
      await tester.pumpWidget(MaterialApp(
        home: FlexibleScaffold(
          title: 'title',
          bannerUrl: ImageUrl.empty,
          onBackButtonPressed: () {},
          isFlexible: true,
          tabs: const [Tab(text: 'tab1'), Tab(text: 'tab2')],
          sliverContent: TabBarView(
            children: [Container(key: sliverContentKey1), Container(key: sliverContentKey2)],
          ),
        ),
      ));

      expect(find.byType(DefaultTabController), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(NestedScrollView), findsOneWidget);

      // check icon back button
      expect(find.ancestor(of: find.byType(SliverAppBar), matching: find.byType(NestedScrollView)), findsOneWidget);
      expect(find.ancestor(of: find.byType(IconButton), matching: find.byType(SliverAppBar)), findsOneWidget);
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(IconButton)), findsOneWidget);

      // check flexibleSpace when fixed
      expect(find.ancestor(of: find.byType(LayoutBuilder), matching: find.byType(SliverAppBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(FlexibleSpaceBar), matching: find.byType(LayoutBuilder)), findsNWidgets(2));
      expect(find.ancestor(of: find.byType(Padding), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(2));
      expect(find.ancestor(of: find.byType(FittedBox), matching: find.byType(Padding)), findsNWidgets(2));
      expect(find.ancestor(of: find.text('title'), matching: find.byType(FittedBox)), findsOneWidget);
      expect(find.ancestor(of: find.byType(Container), matching: find.byType(FlexibleSpaceBar)), findsNWidgets(3));
      expect(find.ancestor(of: find.byType(SvgPicture), matching: find.byType(Container)), findsOneWidget);

      // check tabs (external value)
      expect(find.text('tab1'), findsOneWidget);
      expect(find.text('tab2'), findsOneWidget);

      // check sliverContent (external value)
      expect(find.byType(TabBarView), findsOneWidget);
      expect(find.byKey(sliverContentKey1), findsOneWidget);
    });

    testWidgets('must returns event when back button pressed', (tester) async {
      var backButtonPressed = false;
      await tester.pumpWidget(MaterialApp(
        home: FlexibleScaffold(
          title: 'title',
          bannerUrl: ImageUrl.empty,
          onBackButtonPressed: () {
            backButtonPressed = true;
          },
          sliverContent: const SliverFillRemaining(),
        ),
      ));

      await tester.tap(find.byType(IconButton));

      expect(backButtonPressed, isTrue);
    });
  });
}
