import 'package:flutter_test/flutter_test.dart';
import 'package:kana_checker/src/verify_conditions.dart';

void main() {
  // TODO melhorar o padrao dos testes
  final verifyConditions = VerifyConditions(0.8);

  test('must return true when points checked are above of approve percentage', () {
    expect(verifyConditions.allUserPointsChecked([true, true, true, true, true]), isTrue);
    expect(verifyConditions.allUserPointsChecked([true, true, true, true, false]), isTrue);
  });
  test('must return false when points checked are below of approve percentage', () {
    expect(verifyConditions.allUserPointsChecked([false, false, false, false, false]), isFalse);
    expect(verifyConditions.allUserPointsChecked([true, true, true, false, false]), isFalse);
  });
  test('must return true when all strokes checked are true', () {
    expect(
        verifyConditions.allDataStrokesChecked([
          [true, true, true, true, true]
        ]),
        isTrue);
    expect(
        verifyConditions.allDataStrokesChecked([
          [true, true],
          [true, true, true],
          [true]
        ]),
        isTrue);
  });
  test('must return false when any stroke checked is false', () {
    expect(
        verifyConditions.allDataStrokesChecked([
          [false, true, true, true, true]
        ]),
        isFalse);
    expect(
        verifyConditions.allDataStrokesChecked([
          [true, true],
          [true, false, true],
          [true]
        ]),
        isFalse);
  });
}
