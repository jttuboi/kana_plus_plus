import 'dart:ui';

abstract class IKanaCheckerService {
  bool checkKana(String kana, int maxStrokes, List<List<Offset>> normalizedStrokes);
}
