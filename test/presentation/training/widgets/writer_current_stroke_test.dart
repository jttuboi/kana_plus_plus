import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';

import '../../../utils/utils.dart';

void main() {
  group('WriteCurrentStroke', () {
    testWidgets('render correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: WriteCurrentStroke(
          canGesture: true,
          regionSize: 100,
          strokeForDraw: 'M 66.87 26.75 C 68.2729 27.6427 69.8058 29.0247 71.2034 30.5786 C 72.5455 32.0708 73.7627 33.7216 74.62 35.25',
          onStrokeEnded: (stroke) {},
        ),
      ));

      tester
        ..expectWidget<GestureDetector>()
        ..expectCustomPaintWith<CurrentStrokePainter>();
    });

    testWidgets('creates a stroke drawing on gesture detector', (tester) async {
      var strokeEnded = false;
      await tester.pumpWidget(MaterialApp(
          home: WriteCurrentStroke(
        canGesture: true,
        regionSize: 100,
        strokeForDraw: 'M 66.87 26.75 C 68.2729 27.6427 69.8058 29.0247 71.2034 30.5786 C 72.5455 32.0708 73.7627 33.7216 74.62 35.25',
        onStrokeEnded: (stroke) {
          strokeEnded = true;
        },
      )));

      tester.expectWidget<GestureDetector>();

      final stateBeforeWrite = tester.state<WriteCurrentStrokeState>(find.byType(WriteCurrentStroke));
      expect(stateBeforeWrite.currentStroke, isEmpty);

      final drawStroke = await tester.startGesture(const Offset(50, 50));
      await tester.pump(kLongPressTimeout + kPressTimeout);
      await drawStroke.moveTo(const Offset(70, 70));
      await tester.pump();

      final stateInWriting = tester.state<WriteCurrentStrokeState>(find.byType(WriteCurrentStroke));
      expect(stateInWriting.currentStroke, isNotEmpty);

      await drawStroke.up();
      await tester.pump();

      final stateAfterWrite = tester.state<WriteCurrentStrokeState>(find.byType(WriteCurrentStroke));
      expect(stateAfterWrite.currentStroke, isEmpty);
      expect(strokeEnded, isTrue);
    });

    testWidgets('blocks drawing when cannot gesture', (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: WriteCurrentStroke(
        canGesture: false,
        regionSize: 100,
        strokeForDraw: 'M 66.87 26.75 C 68.2729 27.6427 69.8058 29.0247 71.2034 30.5786 C 72.5455 32.0708 73.7627 33.7216 74.62 35.25',
        onStrokeEnded: (stroke) {},
      )));

      tester.expectWidget<GestureDetector>();

      final stateBeforeWrite = tester.state<WriteCurrentStrokeState>(find.byType(WriteCurrentStroke));
      expect(stateBeforeWrite.currentStroke, isEmpty);

      final drawStroke = await tester.startGesture(const Offset(50, 50));
      await tester.pump(kLongPressTimeout + kPressTimeout);
      await drawStroke.moveTo(const Offset(70, 70));
      await tester.pump();

      final stateInWriting = tester.state<WriteCurrentStrokeState>(find.byType(WriteCurrentStroke));
      expect(stateInWriting.currentStroke, isEmpty);

      await drawStroke.up();
      await tester.pump();

      final stateAfterWrite = tester.state<WriteCurrentStrokeState>(find.byType(WriteCurrentStroke));
      expect(stateAfterWrite.currentStroke, isEmpty);
    });
  });
}
