// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_stats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingStatsAdapter extends TypeAdapter<TrainingStats> {
  @override
  final int typeId = 0;

  @override
  TrainingStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingStats(
      showHint: fields[0] as bool,
      type: fields[1] as KanaType,
      wordsQuantity: fields[2] as int,
      words: (fields[3] as List).cast<WordStats>(),
    );
  }

  @override
  void write(BinaryWriter writer, TrainingStats obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.showHint)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.wordsQuantity)
      ..writeByte(3)
      ..write(obj.words);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
