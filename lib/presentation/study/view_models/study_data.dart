class StudyData {
  const StudyData(this.leftLetter, this.rightLetter);

  final String leftLetter;
  final String rightLetter;

  static const empty = StudyData('', '');
}
