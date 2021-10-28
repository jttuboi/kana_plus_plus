enum UpdateKanaSituation {
  changeKana,
  changeWord,
  changeTheLastWord,
}

extension UpdateKanaSituationExtension on UpdateKanaSituation {
  bool get isChangeKana => this == UpdateKanaSituation.changeKana;
  bool get isChangeWord => this == UpdateKanaSituation.changeWord;
  bool get isChangeTheLastWord => this == UpdateKanaSituation.changeTheLastWord;
}
