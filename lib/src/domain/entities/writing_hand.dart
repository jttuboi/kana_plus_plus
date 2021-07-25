enum WritingHand {
  left,
  right,
}

extension WritingHandExtension on WritingHand {
  bool get isLeft => this == WritingHand.left;
  bool get isRight => this == WritingHand.right;
  bool equal(WritingHand other) => this == other;
}
