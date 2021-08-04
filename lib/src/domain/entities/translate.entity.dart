import 'package:kana_plus_plus/src/domain/core/consts.dart';

class Translate {
  const Translate({
    required this.id,
    required this.code,
    required this.translate,
  });

  const Translate.empty()
      : id = -1,
        code = Default.locale,
        translate = "";

  final int id;
  final String code;
  final String translate;

  @override
  String toString() {
    return "Translate($id, $code, $translate)";
  }
}
