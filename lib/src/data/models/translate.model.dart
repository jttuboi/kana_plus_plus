import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/translate.entity.dart';

class TranslateModel extends Translate {
  const TranslateModel({
    required int id,
    required String code,
    required String translate,
  }) : super(
          id: id,
          code: code,
          translate: translate,
        );

  const TranslateModel.empty() : super.empty();

  factory TranslateModel.fromMap(Map<String, dynamic> map) {
    return TranslateModel(
      id: map[TTranslates.wordId] as int,
      code: map[TTranslates.code] as String,
      translate: map[TTranslates.translate] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      TTranslates.wordId: id,
      TTranslates.code: code,
      TTranslates.translate: translate,
    };
  }
}
