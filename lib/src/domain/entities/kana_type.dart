enum KanaType {
  none,
  hiragana,
  katakana,
  both,
}

extension KanaTypeExtension on KanaType {
  bool get isOnlyHiragana => this == KanaType.hiragana;
  bool get isOnlyKatakana => this == KanaType.katakana;
  bool get isBoth => this == KanaType.both;
  bool get isNone => this == KanaType.none;
  bool equal(KanaType other) => this == other;
}
