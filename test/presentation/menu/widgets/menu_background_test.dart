import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/menu/menu.dart';

void main() {
  group('MenuBackground', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: MenuBackground()));

      expect(find.byType(FallingKanaAnimation), findsNWidgets(16));
      expect(find.byWidgetPredicate((widget) => widget is CustomPaint && widget.painter == const Layer0Painter()), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is CustomPaint && widget.painter == const Layer1Painter()), findsOneWidget);
      expect(find.byWidgetPredicate((widget) => widget is CustomPaint && widget.painter == const Layer2Painter()), findsOneWidget);
    });
  });
}
