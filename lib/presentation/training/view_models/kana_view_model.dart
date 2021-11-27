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
    required this.strokes,
    this.userStrokes = const <List<Offset>>[],
  });

  final String id;
  final KanaViewerStatus status;
  final KanaType kanaType;
  final String romaji;
  final List<String> strokes;
  final List<List<Offset>> userStrokes;

  @override
  List<Object?> get props => [id, status, kanaType, romaji, strokes, userStrokes];

  factory KanaViewModel.fromKanaModel(KanaModel kanaModel, bool first) {
    return KanaViewModel(
      id: kanaModel.id,
      status: first ? KanaViewerStatus.select : KanaViewerStatus.normal,
      kanaType: kanaModel.kanaType,
      romaji: kanaModel.romaji,
      strokes: kanaModel.strokes,
    );
  }

  KanaViewModel copyWith({
    String? id,
    KanaViewerStatus? status,
    KanaType? kanaType,
    String? romaji,
    List<String>? strokes,
    List<List<Offset>>? userStrokes,
  }) {
    return KanaViewModel(
      id: id ?? this.id,
      status: status ?? this.status,
      kanaType: kanaType ?? this.kanaType,
      romaji: romaji ?? this.romaji,
      strokes: strokes ?? this.strokes,
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
