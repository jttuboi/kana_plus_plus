// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kana_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KanaStatsAdapter extends TypeAdapter<KanaStats> {
  @override
  final int typeId = 2;

  @override
  KanaStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KanaStats(
      id: fields[0] as String,
      correct: fields[1] as bool,
      idWrote: fields[2] as String,
      strokes: (fields[3] as List).cast<StrokeStats>(),
    );
  }

  @override
  void write(BinaryWriter writer, KanaStats obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.correct)
      ..writeByte(2)
      ..write(obj.idWrote)
      ..writeByte(3)
      ..write(obj.strokes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KanaStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
