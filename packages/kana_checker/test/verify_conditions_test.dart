import 'package:flutter_test/flutter_test.dart';
import 'package:kana_checker/src/verify_conditions.dart';

void main() {
  late VerifyConditions verifyConditions;
  group('VerifyConditions', () {
    group('for percentageToApprove = 0.8', () {
      setUpAll(() {
        verifyConditions = VerifyConditions(0.8);
      });

      test('checks conditions of user points must be true', () {
        expect(verifyConditions.allUserPointsChecked([true, true, true, true, true]), isTrue);
        expect(verifyConditions.allUserPointsChecked([true, true, true, true, false]), isTrue);
      });

      test('checks conditions of user points must be false', () {
        expect(verifyConditions.allUserPointsChecked([false, false, false, false, false]), isFalse);
        expect(verifyConditions.allUserPointsChecked([true, true, true, false, false]), isFalse);
      });

      test('checks conditions of list of strokes must be all true', () {
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

      test('checks conditions of list of strokes must be only once false', () {
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
    });

    group('for percentageToApprove = 0.9', () {
      setUpAll(() {
        verifyConditions = VerifyConditions(0.9);
      });

      test('checks conditions of user points must be true', () {
        expect(verifyConditions.allUserPointsChecked([true, true, true, true, true]), isTrue);
      });

      test('checks conditions of user points must be false', () {
        expect(verifyConditions.allUserPointsChecked([false, false, false, false, false]), isFalse);
        expect(verifyConditions.allUserPointsChecked([true, true, true, true, false]), isFalse);
      });

      test('checks conditions of list of strokes must be all true', () {
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

      test('checks conditions of list of strokes must be only once false', () {
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
    });
  });
}
