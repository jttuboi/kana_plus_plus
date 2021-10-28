import 'package:kwriting/core/core.dart';

class WritingHandData {
  const WritingHandData({
    required this.writingHand,
    required this.iconUrl,
  });

  const WritingHandData.empty()
      : writingHand = WritingHand.right,
        iconUrl = IconUrl.empty;

  final WritingHand writingHand;
  final String iconUrl;

  @override
  String toString() {
    return 'WritingHandData($writingHand, $iconUrl)';
  }
}
