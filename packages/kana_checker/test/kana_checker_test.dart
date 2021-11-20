// ignore_for_file: prefer_int_literals

import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:kana_checker/kana_checker.dart';

void main() {
  late KanaChecker kanaChecker;

  setUpAll(() async {
    kanaChecker = KanaChecker();
    TestWidgetsFlutterBinding.ensureInitialized();
    return kanaChecker.initialize();
  });

  group('KanaChecker', () {
    test('reads and checks the kana is succeed', () {
      expect(kanaChecker.checkKana('ー', strokesSucceed1), isTrue);
      expect(kanaChecker.checkKana('ー', strokesSucceed2), isTrue);
      expect(kanaChecker.checkKana('ー', strokesSucceed3), isTrue);
    });

    test('reads and checks the kana is fail', () {
      expect(kanaChecker.checkKana('ー', strokesFail), isFalse);
    });
  });
}

const strokesSucceed1 = [
  [
    Point(0.1, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.3, 0.5),
    Point(0.3, 0.5),
    Point(0.3, 0.5),
    Point(0.3, 0.5),
    Point(0.6, 0.5),
    Point(0.6, 0.5),
    Point(0.7, 0.5),
    Point(0.7, 0.5),
    Point(0.8, 0.5),
    Point(0.8, 0.4),
    Point(0.8, 0.4),
    Point(0.8, 0.4),
    Point(0.9, 0.4),
  ]
];

const strokesSucceed2 = [
  [
    Point(0.1, 0.5),
    Point(0.1, 0.5),
    Point(0.1, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.4),
    Point(0.3, 0.4),
    Point(0.3, 0.4),
    Point(0.4, 0.4),
    Point(0.4, 0.4),
    Point(0.6, 0.4),
    Point(0.6, 0.4),
    Point(0.7, 0.4),
    Point(0.7, 0.4),
    Point(0.9, 0.4),
  ]
];

const strokesSucceed3 = [
  [
    Point(0.1, 0.5),
    Point(0.1, 0.5),
    Point(0.1, 0.4),
    Point(0.2, 0.4),
    Point(0.2, 0.4),
    Point(0.3, 0.4),
    Point(0.5, 0.4),
    Point(0.6, 0.4),
    Point(0.7, 0.4),
    Point(0.8, 0.4),
    Point(0.8, 0.4),
    Point(0.8, 0.4),
    Point(0.9, 0.4),
    Point(0.9, 0.4),
  ]
];

const strokesFail = [
  [
    Point(0.1, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.3, 0.4),
    Point(0.3, 0.3),
    Point(0.4, 0.3),
    Point(0.4, 0.4),
    Point(0.4, 0.4),
    Point(0.5, 0.0),
  ]
];
