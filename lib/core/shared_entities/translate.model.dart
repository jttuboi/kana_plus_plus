// ignore_for_file: sort_constructors_first

class TranslateModel {
  const TranslateModel({
    required this.id,
    required this.english,
    required this.portuguese,
    required this.spanish,
  });

  final String id;
  final String english;
  final String portuguese;
  final String spanish;

  static const TranslateModel empty = TranslateModel(id: '', english: '', portuguese: '', spanish: '');

  factory TranslateModel.fromJson(Map<String, dynamic> json) {
    return TranslateModel(
      id: json['id'],
      english: json['en'],
      portuguese: json['pt'],
      spanish: json['es'],
    );
  }

  TranslateModel copyWith({
    String? id,
    String? english,
    String? portuguese,
    String? spanish,
  }) {
    return TranslateModel(
      id: id ?? this.id,
      english: english ?? this.english,
      portuguese: portuguese ?? this.portuguese,
      spanish: spanish ?? this.spanish,
    );
  }

  String toTranslateStr(String languageCode) {
    switch (languageCode) {
      case 'pt':
        return portuguese;
      case 'es':
        return spanish;
      default:
        return english;
    }
  }
}
