import 'package:flutter/widgets.dart';

import 'package:kana_plus_plus/src/domain/core/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_viewer_content.dart';

class KanaResult {
  KanaResult({
    required this.id,
    required this.isCorrect,
    required this.idWrote,
    required this.strokesDrew,
  });

  factory KanaResult.fromKanaViewerContent(KanaViewerContent kanaContent) {
    return KanaResult(
      isCorrect: kanaContent.status.isShowCorrect,
      id: kanaContent.id,
      idWrote: kanaContent.kanaIdWrote,
      strokesDrew: kanaContent.strokesDrew,
    );
  }

  final String id;
  final bool isCorrect;
  final String idWrote;
  final List<List<Offset>> strokesDrew;

  @override
  String toString() {
    return 'KanaResult($id, $isCorrect, $idWrote, $strokesDrew)';
  }
}
