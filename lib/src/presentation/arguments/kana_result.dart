import 'package:flutter/widgets.dart';

class KanaResult {
  const KanaResult({
    required this.id,
    required this.imageUrl,
    required this.isCorrect,
    required this.idWrote,
    required this.strokesDrew,
  });

  final int id;
  final String imageUrl;
  final bool isCorrect;
  final int idWrote;
  final List<List<Offset>> strokesDrew;
}
