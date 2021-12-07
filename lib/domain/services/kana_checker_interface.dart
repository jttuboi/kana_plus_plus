import 'package:flutter/material.dart';

abstract class IKanaChecker {
  Future<void> initialize();
  bool checkKana(String kana, int strokeIndex, List<Offset> normalizedStroke);
}
