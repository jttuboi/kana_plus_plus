import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/core/writing_hand.dart';

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
