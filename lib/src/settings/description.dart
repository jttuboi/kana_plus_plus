import 'package:kana_plus_plus/src/settings/description_type.dart';

class Description {
  Description.title(this.text) {
    type = DescriptionType.title;
  }

  Description.content(this.text) {
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
