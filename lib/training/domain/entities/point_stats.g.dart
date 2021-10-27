// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../training/domain/entities/point_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PointStatsAdapter extends TypeAdapter<PointStats> {
  @override
  final int typeId = 4;

  @override
  PointStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PointStats(
      x: fields[0] as double,
      y: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, PointStats obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.x)
      ..writeByte(1)
      ..write(obj.y);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is PointStatsAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
