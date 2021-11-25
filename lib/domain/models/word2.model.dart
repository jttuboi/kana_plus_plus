import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

class Word2Model extends Word {
  Word2Model({
    required String id,
    required String imageUrl,
    String romaji = '',
    KanaType type = KanaType.both,
  }) : super(
          id: id,
          romaji: romaji,
          type: type,
          imageUrl: imageUrl,
        );

  Word2Model.empty() : super.empty();

  factory Word2Model.fromJson(Map<String, dynamic> json) {
    return Word2Model(
      id: json[TWords.id] as String,
      romaji: json[TWords.romaji] as String,
      type: toKanaType(json[TWords.type] as String),
      imageUrl: ImageUrl.imageFolder + (json[TWords.imageUrl] as String),
    );
  }
}
