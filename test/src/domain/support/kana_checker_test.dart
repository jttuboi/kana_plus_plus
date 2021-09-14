import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/domain/support/kana_checker.dart';

void main() {
  final kanaChecker = KanaChecker();

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    return kanaChecker.load();
  });

  test('must return true when points is properly inside of data stroke', () {
    expect(kanaChecker.checkKana('ー', strokesSucceed1), isTrue);
    expect(kanaChecker.checkKana('ー', strokesSucceed2), isTrue);
    expect(kanaChecker.checkKana('ー', strokesSucceed3), isTrue);
  });
  test('must return false when points is properly inside of data stroke', () {
    expect(kanaChecker.checkKana('ー', strokesFail1), isFalse);
    expect(kanaChecker.checkKana('ー', strokesFail2), isFalse);
  });
  test('must return true when points checked are above of approve percentage', () {
    expect(kanaChecker.allUserPointsChecked([true, true, true, true, true]), isTrue);
    expect(kanaChecker.allUserPointsChecked([true, true, true, true, false]), isTrue);
  });
  test('must return false when points checked are below of approve percentage', () {
    expect(kanaChecker.allUserPointsChecked([false, false, false, false, false]), isFalse);
    expect(kanaChecker.allUserPointsChecked([true, true, true, false, false]), isFalse);
  });
  test('must return true when all strokes checked are true', () {
    expect(
        kanaChecker.allDataStrokesChecked([
          [true, true, true, true, true]
        ]),
        isTrue);
    expect(
        kanaChecker.allDataStrokesChecked([
          [true, true],
          [true, true, true],
          [true]
        ]),
        isTrue);
  });
  test('must return false when any stroke checked is false', () {
    expect(
        kanaChecker.allDataStrokesChecked([
          [false, true, true, true, true]
        ]),
        isFalse);
    expect(
        kanaChecker.allDataStrokesChecked([
          [true, true],
          [true, false, true],
          [true]
        ]),
        isFalse);
  });
}

const strokesSucceed1 = [
  [
    Offset(0.1, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.5),
    Offset(0.3, 0.5),
    Offset(0.3, 0.5),
    Offset(0.3, 0.5),
    Offset(0.3, 0.5),
    Offset(0.6, 0.5),
    Offset(0.6, 0.5),
    Offset(0.7, 0.5),
    Offset(0.7, 0.5),
    Offset(0.8, 0.5),
    Offset(0.8, 0.4),
    Offset(0.8, 0.4),
    Offset(0.8, 0.4),
    Offset(0.9, 0.4)
  ]
];
const strokesSucceed2 = [
  [
    Offset(0.1, 0.5),
    Offset(0.1, 0.5),
    Offset(0.1, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.4),
    Offset(0.3, 0.4),
    Offset(0.3, 0.4),
    Offset(0.4, 0.4),
    Offset(0.4, 0.4),
    Offset(0.6, 0.4),
    Offset(0.6, 0.4),
    Offset(0.7, 0.4),
    Offset(0.7, 0.4),
    Offset(0.9, 0.4)
  ]
];
const strokesSucceed3 = [
  [
    Offset(0.1, 0.5),
    Offset(0.1, 0.5),
    Offset(0.1, 0.4),
    Offset(0.2, 0.4),
    Offset(0.2, 0.4),
    Offset(0.3, 0.4),
    Offset(0.5, 0.4),
    Offset(0.6, 0.4),
    Offset(0.7, 0.4),
    Offset(0.8, 0.4),
    Offset(0.8, 0.4),
    Offset(0.8, 0.4),
    Offset(0.9, 0.4),
    Offset(0.9, 0.4)
  ]
];

const strokesFail1 = [
  [
    Offset(0.1, 0.6),
    Offset(0.1, 0.6),
    Offset(0.2, 0.6),
    Offset(0.2, 0.6),
    Offset(0.2, 0.5),
    Offset(0.3, 0.5),
    Offset(0.3, 0.5),
    Offset(0.4, 0.5),
    Offset(0.4, 0.5),
    Offset(0.6, 0.6),
    Offset(0.7, 0.6),
    Offset(0.7, 0.6),
    Offset(0.9, 0.6)
  ]
];
const strokesFail2 = [
  [
    Offset(0.1, 0.5),
    Offset(0.2, 0.5),
    Offset(0.2, 0.5),
    Offset(0.3, 0.4),
    Offset(0.3, 0.3),
    Offset(0.4, 0.3),
    Offset(0.4, 0.4),
    Offset(0.4, 0.4),
    Offset(0.5, 0.0)
  ]
];
