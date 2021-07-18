class PreTrainingArguments {
  const PreTrainingArguments({
    required this.showHint,
    required this.kanaType,
    required this.quantityOfCards,
  });

  final bool showHint;
  final int kanaType;
  final int quantityOfCards;
}
