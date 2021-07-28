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
      id: map[Column.wordId] as int,
      code: map[Column.code] as String,
      translate: map[Column.translate] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Column.wordId: id,
      Column.code: code,
      Column.translate: translate,
    };
  }

  @override
  String toString() {
    return "Translate($id, $code, $translate)";
  }
}
