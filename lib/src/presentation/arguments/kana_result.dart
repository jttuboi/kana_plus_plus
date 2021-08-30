import 'package:flutter/widgets.dart';

class KanaResult {
  const KanaResult({
    required this.id,
    required this.imageUrl,
    required this.isCorrect,
    required this.idWrote,
    required this.strokesDrew,
  });

  final String id;
  final String imageUrl;
  final bool isCorrect;
  final String idWrote;
  final List<List<Offset>> strokesDrew;

  @override
  String toString() {
    return 'KanaResult($id, $imageUrl, $isCorrect, $idWrote, $strokesDrew)';
  }
}
