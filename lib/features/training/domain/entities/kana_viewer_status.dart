enum KanaViewerStatus {
  showInitial,
  showSelected,
  showCorrect,
  showWrong,
}

extension StatusExtension on KanaViewerStatus {
  bool get isShowInitial => this == KanaViewerStatus.showInitial;
  bool get isShowSelected => this == KanaViewerStatus.showSelected;
  bool get isShowCorrect => this == KanaViewerStatus.showCorrect;
  bool get isShowWrong => this == KanaViewerStatus.showWrong;
}
