import 'package:kwriting/src/domain/utils/kana_type.dart';

class PreTrainingArguments {
  const PreTrainingArguments({
    required this.showHint,
    required this.kanaType,
    required this.quantityOfWords,
  });

  final bool showHint;
  final KanaType kanaType;
  final int quantityOfWords;
}
