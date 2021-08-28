import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_viewer_status.dart';

class KanaViewerContent {
  KanaViewerContent({
    required this.id,
    required this.status,
    required this.kanaImageUrl,
    required this.romajiImageUrl,
    required this.strokesNumber,
    required this.kanaType,
    this.kanaIdWrote = -1,
    this.strokesDrew = const [],
  });

  final int id;
  final KanaViewerStatus status;
  final String kanaImageUrl;
  final String romajiImageUrl;
  final int strokesNumber;
  final KanaType kanaType;
  late int kanaIdWrote;
  late List<List<Offset>> strokesDrew;

  @override
  String toString() {
    return 'KanaV($id, ${status.toString()}, $kanaImageUrl, $romajiImageUrl, $strokesNumber, ${kanaType.toString()}, $kanaIdWrote, $strokesDrew)';
  }
}
