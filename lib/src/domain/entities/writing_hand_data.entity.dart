import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';

class WritingHandData {
  const WritingHandData({
    required this.writingHand,
    required this.iconUrl,
  });

  const WritingHandData.empty()
      : writingHand = WritingHand.right,
        // TODO url
        iconUrl = "";

  final WritingHand writingHand;
  final String iconUrl;

  @override
  String toString() {
    return "WritingHandData($writingHand, $iconUrl)";
  }
}
