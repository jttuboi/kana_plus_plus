import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/translate.entity.dart';

class TranslateModel extends Translate {
  TranslateModel({
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

  TranslateModel.empty() : super.empty();

  factory TranslateModel.fromJson(Map<String, dynamic> json) {
    return TranslateModel(
      id: json[TTranslates.id] as String,
      english: json[TTranslates.english] as String,
      portuguese: json[TTranslates.portuguese] as String,
      spanish: json[TTranslates.spanish] as String,
    );
  }
}
