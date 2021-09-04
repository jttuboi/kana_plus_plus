import 'package:flutter/widgets.dart';

class KanaResult {
  const KanaResult({
    required this.id,
    required this.isCorrect,
    required this.idWrote,
    required this.strokesDrew,
  });

  final String id;
  final bool isCorrect;
  final String idWrote;
  final List<List<Offset>> strokesDrew;

  @override
  String toString() {
    return 'KanaResult($id, $isCorrect, $idWrote, $strokesDrew)';
  }
}
