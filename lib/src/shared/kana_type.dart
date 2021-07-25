enum KanaType {
  onlyHiragana,
  onlyKatakana,
  both,
}

extension KanaTypeExtension on KanaType {
  bool get isOnlyHiragana => this == KanaType.onlyHiragana;
  bool get isOnlyKatakana => this == KanaType.onlyKatakana;
  bool get isBoth => this == KanaType.both;
  bool equal(KanaType other) => this == other;
}
