enum KanaViewerStatus {
  select,
  normal,
  correct,
  wrong,
}

extension KanaViewerStatusExtension on KanaViewerStatus {
  bool get isSelect => this == KanaViewerStatus.select;
  bool get isNormal => this == KanaViewerStatus.normal;
  bool get isCorrect => this == KanaViewerStatus.correct;
  bool get isWrong => this == KanaViewerStatus.wrong;
}
