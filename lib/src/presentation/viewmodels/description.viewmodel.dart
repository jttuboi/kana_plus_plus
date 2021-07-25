import 'package:kana_plus_plus/src/domain/entities/description_type.dart';

class DescriptionViewModel {
  DescriptionViewModel.title(this.text) {
    type = DescriptionType.title;
  }

  DescriptionViewModel.content(this.text) {
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
