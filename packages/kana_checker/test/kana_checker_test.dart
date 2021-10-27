import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:kana_checker/kana_checker.dart';

void main() {
  // TODO melhorar o padrao dos testes
  final kanaChecker = KanaChecker();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    return kanaChecker.preloadData();
  });

  test('must return true when points is properly inside of data stroke', () {
    expect(kanaChecker.checkKana('ー', strokesSucceed1), isTrue);
    expect(kanaChecker.checkKana('ー', strokesSucceed2), isTrue);
    expect(kanaChecker.checkKana('ー', strokesSucceed3), isTrue);
  });
  // test('must return false when points is properly inside of data stroke', () {
  //   expect(kanaChecker.checkKana('ー', strokesFail1), isFalse);
  //   expect(kanaChecker.checkKana('ー', strokesFail2), isFalse);
  // });
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

const strokesFail1 = [
  [
    Point(0.1, 0.6),
    Point(0.1, 0.6),
    Point(0.2, 0.6),
    Point(0.2, 0.6),
    Point(0.2, 0.5),
    Point(0.3, 0.5),
    Point(0.3, 0.5),
    Point(0.4, 0.5),
    Point(0.4, 0.5),
    Point(0.6, 0.6),
    Point(0.7, 0.6),
    Point(0.7, 0.6),
    Point(0.9, 0.6),
  ]
];
const strokesFail2 = [
  [
    Point(0.1, 0.5),
    Point(0.2, 0.5),
    Point(0.2, 0.5),
    Point(0.3, 0.4),
    Point(0.3, 0.3),
    Point(0.4, 0.3),
    Point(0.4, 0.4),
    Point(0.4, 0.4),
    // ignore: prefer_int_literals
    Point(0.5, 0.0),
  ]
];
