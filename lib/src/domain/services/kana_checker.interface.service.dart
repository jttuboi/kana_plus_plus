import 'dart:ui';

abstract class IKanaCheckerService {
  bool checkKana(String kana, List<List<Offset>> normalizedStrokes);
}
