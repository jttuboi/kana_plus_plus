import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/study/study.dart';

void main() {
  group('StudyData', () {
    test('creates properly fields', () {
      const data = StudyData('A', 'B');

      expect(data.leftLetter, 'A');
      expect(data.rightLetter, 'B');
    });

    test('is empty', () {
      const data = StudyData.empty;

      expect(data.leftLetter, '');
      expect(data.rightLetter, '');
    });
  });
}
