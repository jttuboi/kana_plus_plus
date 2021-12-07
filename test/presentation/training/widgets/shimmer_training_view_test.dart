import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../utils/utils.dart';

void main() {
  group('ShimmerKanaViewer', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ShimmerTrainingView(),
      ));

      tester
        ..expectWidget<StepProgressIndicator>()
        ..expectWidget<Spacer>(widgetQuantityExpected: 4)
        ..expectWidget<ShimmerKanaViewer>();
      final findAllContainers = find.descendant(of: find.byType(LayoutBuilder), matching: find.byType(Container));
      final blackContainers = tester.widgetList<Container>(findAllContainers).where((container) {
        // ignores container of kana viewer when uses color directly of container
        return container.decoration is BoxDecoration && ((container.decoration! as BoxDecoration).color == Colors.black);
      });
      expect(blackContainers.length, 2);
    });
  });
}
