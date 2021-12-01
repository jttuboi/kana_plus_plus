import 'package:hive/hive.dart';

part 'kana_type.g.dart';

@HiveType(typeId: 100)
enum KanaType {
  @HiveField(0)
  both,
  @HiveField(1)
  hiragana,
  @HiveField(2)
  katakana,
}

extension KanaTypeExtension on KanaType {
  bool get isOnlyHiragana => this == KanaType.hiragana;
  bool get isOnlyKatakana => this == KanaType.katakana;
  bool get isBoth => this == KanaType.both;
  bool equal(KanaType other) => this == other;
}
