import 'package:flutter/material.dart';

class KanaResult {
  const KanaResult({
    required this.correct,
    required this.kana,
    required this.userKana,
  });

  final bool correct;
  final Image kana;
  final Image userKana;
}
