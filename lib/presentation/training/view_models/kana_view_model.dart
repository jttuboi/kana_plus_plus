// ignore_for_file: sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

class KanaViewModel extends Equatable {
  const KanaViewModel({
    required this.id,
    required this.status,
    required this.kanaType,
    required this.romaji,
    required this.imageUrl,
    required this.strokesQuantity,
    this.kanaIdWrote = '',
    this.userStrokes = const <List<Offset>>[],
  });

  final String id;
  final KanaViewerStatus status;
  final KanaType kanaType;
  final String romaji;
  final String imageUrl;
  final int strokesQuantity;
  final String kanaIdWrote;
  final List<List<Offset>> userStrokes;

  @override
  List<Object?> get props => [id, status, kanaType, romaji, imageUrl, strokesQuantity, kanaIdWrote, userStrokes];

  factory KanaViewModel.fromKanaModel(KanaModel kanaModel, bool first) {
    return KanaViewModel(
      id: kanaModel.id,
      status: first ? KanaViewerStatus.select : KanaViewerStatus.normal,
      kanaType: kanaModel.kanaType,
      romaji: kanaModel.romaji,
      imageUrl: kanaModel.imageUrl,
      strokesQuantity: kanaModel.strokesQuantity,
    );
  }

  KanaViewModel copyWith({
    String? id,
    KanaViewerStatus? status,
    KanaType? kanaType,
    String? romaji,
    String? imageUrl,
    int? strokesQuantity,
    String? kanaIdWrote,
    List<List<Offset>>? userStrokes,
  }) {
    return KanaViewModel(
      id: id ?? this.id,
      status: status ?? this.status,
      kanaType: kanaType ?? this.kanaType,
      romaji: romaji ?? this.romaji,
      imageUrl: imageUrl ?? this.imageUrl,
      strokesQuantity: strokesQuantity ?? this.strokesQuantity,
      kanaIdWrote: kanaIdWrote ?? this.kanaIdWrote,
      userStrokes: userStrokes ?? this.userStrokes,
    );
  }

  KanaStats toKanaStats() {
    return KanaStats(
      id: id,
      correct: status.isCorrect,
      strokes: userStrokes.map((stroke) => StrokeStats.fromListOffset(stroke)).toList(),
    );
  }
}
