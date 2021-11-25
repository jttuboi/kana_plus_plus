// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:kwriting/core/core.dart';

class Kana extends Equatable {
  const Kana({
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

  @override
  List<Object?> get props => [];

  factory Kana.fromKanaModel(KanaModel kanaModel) {
    return Kana(
      id: kanaModel.id,
      kanaType: kanaModel.kanaType,
      romaji: kanaModel.romaji,
      imageUrl: kanaModel.imageUrl,
      strokesQuantity: kanaModel.strokesQuantity,
    );
  }
}
