import 'package:flutter/widgets.dart';

class KanaResult {
  const KanaResult({
    required this.kanaId,
    required this.correct,
    required this.userKana,
  });

  final int kanaId;
  final bool correct;
  final Image userKana;
}
