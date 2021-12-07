import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:kwriting/presentation/words/words.dart';

void main() {
  group('KanaDetail', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Material(
          child: KanaDetail(
            strokes: [
              'M 31.01 33 C 31.89 33.88 33.76 34.82 36.26 34.75 C 39.2899 34.6621 42.6609 34.3741 46.1713 33.945 C 49.3843 33.5522 52.7142 33.0413 56.0063 32.4574 C 59.3504 31.8643 62.6556 31.196 65.76 30.5 C 67.27 30.16 70.38 29.62 72.38 30',
              'M 49.76 17.62 C 50.64 18.62 51.58 20.88 51.14 22.87 C 50.5069 25.6978 49.9095 28.6575 49.359 31.6987 C 48.8335 34.6025 48.3508 37.5804 47.9209 40.5886 C 47.4973 43.5525 47.125 46.5457 46.8135 49.5261 C 46.4979 52.5452 46.2447 55.5512 46.0636 58.5002 C 45.8747 61.5787 45.7644 64.5951 45.744 67.4997 C 45.7219 70.6528 45.8058 73.6741 46.01 76.5 C 46.1881 78.9757 46.5661 81.3532 47.0597 83.4754 C 47.7026 86.2393 48.5415 88.5701 49.39 90.12',
              'M 65.63 44.12 C 66.38 45.24 66.79 48.51 66.13 50.24 C 65.0923 52.9937 63.9537 55.7091 62.6518 58.4004 C 61.3915 61.0055 59.9783 63.5881 58.3553 66.161 C 56.8354 68.5708 55.1315 70.972 53.1972 73.3756 C 51.4286 75.5731 49.4675 77.7726 47.2781 79.982 C 45.3003 81.9778 43.1364 83.9818 40.76 86 C 38.4144 87.9934 35.8163 89.062 33.3979 89.1204 C 30.6943 89.1856 28.2151 87.9883 26.564 85.4091 C 25.3724 83.5476 24.6121 80.9662 24.51 77.62 C 24.4219 74.8023 25.2785 71.8919 26.9269 69.0631 C 28.3165 66.6785 30.2688 64.3518 32.6922 62.1876 C 34.7991 60.306 37.2621 58.5472 40.021 56.9799 C 42.5211 55.5595 45.2642 54.2964 48.2055 53.2415 C 50.9409 52.2605 53.8478 51.4596 56.89 50.88 C 59.8176 50.3213 62.8652 50.1027 65.8595 50.2438 C 68.9254 50.3883 71.9353 50.9099 74.703 51.8296 C 77.6655 52.8141 80.3506 54.2547 82.53 56.1774 C 84.7622 58.1467 86.4639 60.6216 87.39 63.63 C 88.2448 66.4118 88.5713 69.194 88.3934 71.8913 C 88.2088 74.6913 87.4806 77.3997 86.2358 79.9212 C 85.0407 82.3421 83.3694 84.5905 81.2455 86.5821 C 79.3199 88.3877 77.0223 89.9822 74.3704 91.3025 C 72.0237 92.4709 69.3994 93.4246 66.51 94.12'
            ],
            size: 40,
          ),
        ),
      ));

      expect(find.byType(Stack), findsOneWidget);
      expect(find.byType(Positioned), findsOneWidget);

      final borderPaints = tester.widgetList<CustomPaint>(find.byType(CustomPaint)).where((paint) => paint.painter is BorderPainter).toList();
      expect(borderPaints.length, 1);
      final kanaPaints = tester.widgetList<CustomPaint>(find.byType(CustomPaint)).where((paint) => paint.painter is KanaPainter).toList();
      expect(kanaPaints.length, 1);
    });
  });
}
