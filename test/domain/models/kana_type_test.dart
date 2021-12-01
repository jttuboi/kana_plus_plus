import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('KanaType', () {
    test('has hiragana type', () {
      const kanaHiragana = KanaType.hiragana;
      expect(kanaHiragana.isOnlyHiragana, isTrue);
      expect(kanaHiragana.isOnlyKatakana, isFalse);
      expect(kanaHiragana.isBoth, isFalse);
      expect(kanaHiragana.equal(KanaType.hiragana), isTrue);
      expect(kanaHiragana.equal(KanaType.katakana), isFalse);
      expect(kanaHiragana.equal(KanaType.both), isFalse);
    });
    test('has katakana type', () {
      const kanaKatakana = KanaType.katakana;
      expect(kanaKatakana.isOnlyHiragana, isFalse);
      expect(kanaKatakana.isOnlyKatakana, isTrue);
      expect(kanaKatakana.isBoth, isFalse);
      expect(kanaKatakana.equal(KanaType.hiragana), isFalse);
      expect(kanaKatakana.equal(KanaType.katakana), isTrue);
      expect(kanaKatakana.equal(KanaType.both), isFalse);
    });
    test('has both type', () {
      const kanaBoth = KanaType.both;
      expect(kanaBoth.isOnlyHiragana, isFalse);
      expect(kanaBoth.isOnlyKatakana, isFalse);
      expect(kanaBoth.isBoth, isTrue);
      expect(kanaBoth.equal(KanaType.hiragana), isFalse);
      expect(kanaBoth.equal(KanaType.katakana), isFalse);
      expect(kanaBoth.equal(KanaType.both), isTrue);
    });
  });
}
