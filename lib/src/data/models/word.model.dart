import 'package:kana_plus_plus/src/data/models/translate_word.model.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';

class WordModel {
  WordModel({
    required this.id,
    required this.word,
    required this.romaji,
    required this.imageUrl,
    required this.type,
    required this.kanasId,
    required this.tags,
    required this.translate,
  });

  final int id;
  final String word;
  final String romaji;
  final String imageUrl;
  final KanaType type;
  final List<int> kanasId;
  final List<String> tags;
  final TranslateWordModel translate; // take by the current language code
}
