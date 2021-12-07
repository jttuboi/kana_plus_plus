import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';

class TrainingSettings extends Equatable {
  const TrainingSettings({
    required this.showHint,
    required this.kanaType,
    required this.quantityOfWords,
    required this.languageCode,
  });

  final bool showHint;
  final KanaType kanaType;
  final int quantityOfWords;
  final String languageCode;

  @override
  List<Object?> get props => [showHint, kanaType, quantityOfWords, languageCode];
}
