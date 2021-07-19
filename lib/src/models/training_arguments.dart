import 'package:kana_plus_plus/src/models/kana_result.dart';

class TrainingArguments {
  const TrainingArguments({
    required this.wordsResult,
  });

  final List<List<KanaResult>> wordsResult;
}
