import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/training/kana_viewer_status.dart';

class KanaViewerContent {
  KanaViewerContent({
    required this.status,
    required this.romaji,
    required this.kana,
    this.userKana,
  });

  final KanaViewerStatus status;
  final Image romaji;
  final Image kana;
  final Image? userKana;
}
