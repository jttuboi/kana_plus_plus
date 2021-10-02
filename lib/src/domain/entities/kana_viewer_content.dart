import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/entities/kana.dart';
import 'package:kana_plus_plus/src/domain/utils/kana_type.dart';
import 'package:kana_plus_plus/src/domain/utils/kana_viewer_status.dart';

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

  factory KanaViewerContent.fromKana(Kana kana, bool isFirst) {
    return KanaViewerContent(
      id: kana.id,
      status: isFirst ? KanaViewerStatus.showSelected : KanaViewerStatus.showInitial,
      kanaImageUrl: kana.imageUrl,
      romaji: kana.romaji,
      strokesQuantity: kana.strokesQuantity,
      kanaType: kana.type,
    );
  }

  factory KanaViewerContent.withUpdatedData(KanaViewerContent oldKanaContent, String kanaIdWrote, List<List<Offset>> strokesDrew) {
    return KanaViewerContent(
      id: oldKanaContent.id,
      status: oldKanaContent.id == kanaIdWrote ? KanaViewerStatus.showCorrect : KanaViewerStatus.showWrong,
      kanaImageUrl: oldKanaContent.kanaImageUrl,
      romaji: oldKanaContent.romaji,
      strokesQuantity: oldKanaContent.strokesQuantity,
      kanaType: oldKanaContent.kanaType,
      kanaIdWrote: kanaIdWrote,
      strokesDrew: strokesDrew,
    );
  }

  factory KanaViewerContent.withStatusNext(KanaViewerContent oldKanaContent) {
    return KanaViewerContent(
      id: oldKanaContent.id,
      status: KanaViewerStatus.showSelected,
      kanaImageUrl: oldKanaContent.kanaImageUrl,
      romaji: oldKanaContent.romaji,
      strokesQuantity: oldKanaContent.strokesQuantity,
      kanaType: oldKanaContent.kanaType,
      kanaIdWrote: oldKanaContent.kanaIdWrote,
      strokesDrew: oldKanaContent.strokesDrew,
    );
  }

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
