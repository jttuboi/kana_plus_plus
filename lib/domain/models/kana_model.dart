// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';

class KanaModel extends Equatable {
  const KanaModel({
    required this.id,
    required this.kanaType,
    required this.romaji,
    required this.strokes,
  });

  final String id;
  final KanaType kanaType;
  final String romaji;
  final List<String> strokes;

  @override
  List<Object?> get props => [id, kanaType, romaji, strokes];

  factory KanaModel.fromJson(Map<String, dynamic> json) {
    return KanaModel(
      id: json['id'] as String,
      kanaType: toKanaType(json['type']),
      romaji: json['romaji'] as String,
      strokes: json['strokes'].map<String>((stroke) => stroke as String).toList(),
    );
  }

  KanaModel copyWith({
    String? id,
    KanaType? kanaType,
    String? romaji,
    List<String>? strokes,
  }) {
    return KanaModel(
      id: id ?? this.id,
      kanaType: kanaType ?? this.kanaType,
      romaji: romaji ?? this.romaji,
      strokes: strokes ?? this.strokes,
    );
  }
}
