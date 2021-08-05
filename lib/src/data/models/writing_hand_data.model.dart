import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand_data.entity.dart';

class WritingHandDataModel extends WritingHandData {
  const WritingHandDataModel({
    required WritingHand writingHand,
    required String iconUrl,
  }) : super(
          writingHand: writingHand,
          iconUrl: iconUrl,
        );

  const WritingHandDataModel.empty() : super.empty();

  factory WritingHandDataModel.fromMap(Map<String, dynamic> map) {
    return WritingHandDataModel(
      writingHand: WritingHand.values[map["writing_hand"] as int],
      iconUrl: map["icon_url"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "writing_hand": writingHand,
      "icon_url": iconUrl,
    };
  }
}
