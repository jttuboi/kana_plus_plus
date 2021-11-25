// ignore_for_file: prefer_int_literals

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
      expect(kanaChecker.checkKana('ー', 0, strokesSucceed1), isTrue);
      expect(kanaChecker.checkKana('ー', 0, strokesSucceed2), isTrue);
      expect(kanaChecker.checkKana('ー', 0, strokesSucceed3), isTrue);
    });

    test('reads and checks the kana is fail', () {
      expect(kanaChecker.checkKana('ー', 0, strokesFail), isFalse);
    });
  });
}

const strokesSucceed1 = [
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
  Offset(0.9, 0.4),
];

const strokesSucceed2 = [
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
  Offset(0.9, 0.4),
];

const strokesSucceed3 = [
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
  Offset(0.9, 0.4),
];

const strokesFail = [
  Offset(0.1, 0.5),
  Offset(0.2, 0.5),
  Offset(0.2, 0.5),
  Offset(0.3, 0.4),
  Offset(0.3, 0.3),
  Offset(0.4, 0.3),
  Offset(0.4, 0.4),
  Offset(0.4, 0.4),
  Offset(0.5, 0.0),
];
