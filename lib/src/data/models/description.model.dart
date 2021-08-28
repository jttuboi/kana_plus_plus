import 'package:kana_plus_plus/src/domain/enums/description_type.dart';

class DescriptionModel {
  DescriptionModel.title(this.text) {
    type = DescriptionType.title;
  }

  DescriptionModel.content(this.text) {
    type = DescriptionType.content;
  }

  late final DescriptionType type;
  final String text;

  bool isTitle() {
    return type == DescriptionType.title;
  }

  bool isContent() {
    return type == DescriptionType.content;
  }
}
