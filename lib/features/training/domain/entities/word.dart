import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/training/training.dart';

class Word {
  Word({
    required this.id,
    required this.imageUrl,
    this.romaji = '',
    this.type = KanaType.none,
  });

  Word.empty()
      : id = '',
        imageUrl = ImageUrl.empty,
        romaji = '',
        type = KanaType.none,
        _translate2 = const Translate.empty(),
        kanas = const [];

  final String id;
  final String imageUrl;
  final String romaji;
  final KanaType type;
  late final List<Kana> kanas;

  late final Translate _translate2;
  late String _languageCode;

  String get translate {
    if (_languageCode == TTranslates.english) {
      return _translate2.english;
    } else if (_languageCode == TTranslates.portuguese) {
      return _translate2.portuguese;
    } else if (_languageCode == TTranslates.spanish) {
      return _translate2.spanish;
    }
    return '';
  }

  // ignore: use_setters_to_change_properties
  void setLanguageCode(String languageCode) {
    _languageCode = languageCode;
  }

  // ignore: use_setters_to_change_properties
  void setTranslate(Translate translate) {
    _translate2 = translate;
  }

  @override
  String toString() {
    return 'Word($id, $imageUrl, $romaji, $type, $_translate2, $_languageCode, $kanas)';
  }
}
