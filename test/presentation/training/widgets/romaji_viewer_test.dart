import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';

import '../../../utils/utils.dart';

void main() {
  group('RomajiViewer', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: RomajiViewer('A'),
      ));

      tester
        ..expectWidget<Center>()
        ..expectText('A');
    });
  });
}
