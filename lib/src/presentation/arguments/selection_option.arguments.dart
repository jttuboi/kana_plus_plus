class SelectionOptionArguments {
  const SelectionOptionArguments({
    required this.key,
    required this.label,
    this.iconUrl = '',
  });

  final dynamic key;
  final String label;
  final String iconUrl;
}
