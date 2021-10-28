// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../training/domain/entities/stroke_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StrokeStatsAdapter extends TypeAdapter<StrokeStats> {
  @override
  final int typeId = 3;

  @override
  StrokeStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StrokeStats(
      points: (fields[0] as List).cast<PointStats>(),
    );
  }

  @override
  void write(BinaryWriter writer, StrokeStats obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.points);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is StrokeStatsAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
