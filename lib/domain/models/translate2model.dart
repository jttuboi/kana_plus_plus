import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

class Translate2Model extends Translate {
  Translate2Model({
    required String id,
    required String english,
    required String portuguese,
    required String spanish,
  }) : super(
          id: id,
          english: english,
          portuguese: portuguese,
          spanish: spanish,
        );

  Translate2Model.empty() : super.empty();

  factory Translate2Model.fromJson(Map<String, dynamic> json) {
    return Translate2Model(
      id: json[TTranslates.id] as String,
      english: json[TTranslates.english] as String,
      portuguese: json[TTranslates.portuguese] as String,
      spanish: json[TTranslates.spanish] as String,
    );
  }
}
