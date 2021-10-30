import 'package:hive/hive.dart';

part 'writing_hand.g.dart';

@HiveType(typeId: 101)
enum WritingHand {
  @HiveField(0)
  left,
  @HiveField(1)
  right,
}

extension WritingHandExtension on WritingHand {
  bool get isLeft => this == WritingHand.left;
  bool get isRight => this == WritingHand.right;
  bool equal(WritingHand other) => this == other;
}
