import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type_data.entity.dart';

class KanaTypeDataModel extends KanaTypeData {
  const KanaTypeDataModel({
    required KanaType type,
    required String iconUrl,
  }) : super(
          kanaType: type,
          iconUrl: iconUrl,
        );

  const KanaTypeDataModel.empty() : super.empty();

  factory KanaTypeDataModel.fromMap(Map<String, dynamic> map) {
    return KanaTypeDataModel(
      type: KanaType.values[map["kana_type"] as int],
      iconUrl: map["icon_url"] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "kana_type": kanaType,
      "icon_url": iconUrl,
    };
  }
}
