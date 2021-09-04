class Translate {
  const Translate({
    required this.id,
    required this.english,
    required this.portuguese,
    required this.spanish,
  });

  const Translate.empty()
      : id = '',
        english = '',
        portuguese = '',
        spanish = '';

  final String id;
  final String english;
  final String portuguese;
  final String spanish;

  @override
  String toString() {
    return 'Translate($id, $english, $portuguese, $spanish)';
  }
}
