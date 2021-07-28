enum KanaType {
  none,
  onlyHiragana,
  onlyKatakana,
  both,
}

extension KanaTypeExtension on KanaType {
  bool get isOnlyHiragana => this == KanaType.onlyHiragana;
  bool get isOnlyKatakana => this == KanaType.onlyKatakana;
  bool get isBoth => this == KanaType.both;
  bool get isNone => this == KanaType.none;
  bool equal(KanaType other) => this == other;
}
