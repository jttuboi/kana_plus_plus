import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_viewer_status.dart';

class KanaViewerContent {
  const KanaViewerContent({
    required this.id,
    required this.status,
    required this.kanaImageUrl,
    required this.romajiImageUrl,
    required this.strokesNumber,
    required this.kanaType,
    this.userKana,
  });

  final int id;
  final KanaViewerStatus status;
  final String kanaImageUrl;
  final String romajiImageUrl;
  final int strokesNumber;
  final KanaType kanaType;
  final Image? userKana;

  @override
  String toString() {
    return "KanaV($id, ${status.toString()}, $kanaImageUrl, $romajiImageUrl, $strokesNumber, ${kanaType.toString()}, ${(userKana == null) ? "null" : "hasUserKana"})";
  }
}
