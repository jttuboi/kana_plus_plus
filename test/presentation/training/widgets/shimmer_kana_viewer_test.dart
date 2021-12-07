import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';

import '../../../utils/utils.dart';

void main() {
  group('ShimmerKanaViewer', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ShimmerKanaViewer(
          height: 50,
        ),
      ));

      tester.expectWidget<CarouselSlider>();

      final findAllContainers = find.descendant(of: find.byType(CarouselSlider), matching: find.byType(Container));
      final blackContainers = tester.widgetList<Container>(findAllContainers).where((container) {
        return container.color == Colors.black && container.constraints!.maxWidth == 50.0 && container.constraints!.maxHeight == 50.0;
      });
      expect(blackContainers.length, 5);
    });
  });
}
