// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordStatsAdapter extends TypeAdapter<WordStats> {
  @override
  final int typeId = 1;

  @override
  WordStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordStats(
      id: fields[0] as String,
      correct: fields[1] as bool,
      kanas: (fields[2] as List).cast<KanaStats>(),
    );
  }

  @override
  void write(BinaryWriter writer, WordStats obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.correct)
      ..writeByte(2)
      ..write(obj.kanas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is WordStatsAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
