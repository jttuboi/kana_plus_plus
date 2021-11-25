// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';

class KanaViewModel extends Equatable {
  const KanaViewModel({
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
  List<Object?> get props => [id, kanaType, romaji, imageUrl, strokesQuantity];

  factory KanaViewModel.fromKanaModel(KanaModel kanaModel) {
    return KanaViewModel(
      id: kanaModel.id,
      kanaType: kanaModel.kanaType,
      romaji: kanaModel.romaji,
      imageUrl: kanaModel.imageUrl,
      strokesQuantity: kanaModel.strokesQuantity,
    );
  }
}
