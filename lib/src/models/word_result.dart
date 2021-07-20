import 'package:kana_plus_plus/src/models/kana_result.dart';

class WordResult {
  WordResult({
    required this.wordId,
    required this.kanasResult,
  });

  final int wordId;
  final List<KanaResult> kanasResult;
}
