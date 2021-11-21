// ignore_for_file: sort_constructors_first

import 'package:kwriting/core/core.dart';

class KanaModel {
  const KanaModel({
    required this.id,
    required this.kanaType,
    required this.romaji,
    required this.imageUrl,
    required this.strokesQuantity,
  });

  final String id;
  final KanaType kanaType;
  final String romaji;
  final String imageUrl;
  final int strokesQuantity;

  factory KanaModel.fromJson(Map<String, dynamic> json) {
    return KanaModel(
      id: json['id'],
      kanaType: toKanaType(json['type']),
      romaji: json['romaji'],
      imageUrl: ImageUrl.imageFolder + json['imageUrl'],
      strokesQuantity: json['strokesQuantity'],
    );
  }

  KanaModel copyWith({
    String? id,
    KanaType? kanaType,
    String? romaji,
    String? imageUrl,
    int? strokesQuantity,
  }) {
    return KanaModel(
      id: id ?? this.id,
      kanaType: kanaType ?? this.kanaType,
      romaji: romaji ?? this.romaji,
      imageUrl: imageUrl ?? this.imageUrl,
      strokesQuantity: strokesQuantity ?? this.strokesQuantity,
    );
  }
}
