class PreTrainingArguments {
  const PreTrainingArguments({
    required this.showHint,
    required this.kanaType,
    required this.quantityOfWords,
  });

  final bool showHint;
  final int kanaType;
  final int quantityOfWords;
}
