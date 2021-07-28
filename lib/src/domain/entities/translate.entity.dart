class Translate {
  const Translate({
    required this.id,
    required this.code,
    required this.translate,
  });

  const Translate.empty()
      : id = -1,
        code = "",
        translate = "";

  final int id;
  final String code;
  final String translate;
}
