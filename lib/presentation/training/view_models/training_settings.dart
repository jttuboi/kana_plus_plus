import 'package:kwriting/domain/domain.dart';

class TrainingSettings {
  TrainingSettings({
    required this.showHint,
    required this.kanaType,
    required this.quantityOfWords,
    required this.languageCode,
  });

  final bool showHint;
  final KanaType kanaType;
  final int quantityOfWords;
  final String languageCode;
}
