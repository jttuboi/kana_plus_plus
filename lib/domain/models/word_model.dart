// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/domain/models/translate_model.dart';

class WordModel extends Equatable {
  const WordModel({
    required this.id,
    required this.romaji,
    required this.kanaType,
    required this.imageUrl,
    this.translate = TranslateModel.empty,
    this.kanas = const [],
  });

  final String id;
  final String romaji;
  final KanaType kanaType;
  final String imageUrl;
  final TranslateModel translate;
  final List<KanaModel> kanas;

  @override
  List<Object?> get props => [id, romaji, kanaType, imageUrl, translate, kanas];

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      id: json['id'],
      romaji: json['romaji'],
      kanaType: toKanaType(json['type']),
      imageUrl: ImageUrl.imageFolder + json['imageUrl'],
    );
  }

  WordModel copyWith({
    String? id,
    String? romaji,
    KanaType? kanaType,
    String? imageUrl,
    TranslateModel? translate,
    List<KanaModel>? kanas,
  }) {
    return WordModel(
      id: id ?? this.id,
      romaji: romaji ?? this.romaji,
      kanaType: kanaType ?? this.kanaType,
      imageUrl: imageUrl ?? this.imageUrl,
      translate: translate ?? this.translate,
      kanas: kanas ?? this.kanas,
    );
  }
}
