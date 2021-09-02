import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_type.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_viewer_status.dart';

class KanaViewerContent {
  KanaViewerContent({
    required this.id,
    required this.status,
    required this.kanaImageUrl,
    required this.romaji,
    required this.strokesQuantity,
    required this.kanaType,
    this.kanaIdWrote = '',
    this.strokesDrew = const [],
  });

  final String id;
  final KanaViewerStatus status;
  final String kanaImageUrl;
  final String romaji;
  final int strokesQuantity;
  final KanaType kanaType;
  late String kanaIdWrote;
  late List<List<Offset>> strokesDrew;

  @override
  String toString() {
    return 'KanaViewer($id, ${status.toString()}, $kanaImageUrl, $romaji, $strokesQuantity, ${kanaType.toString()}, $kanaIdWrote, $strokesDrew)';
  }
}
