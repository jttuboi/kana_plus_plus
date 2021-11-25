// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'writing_hand.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WritingHandAdapter extends TypeAdapter<WritingHand> {
  @override
  final int typeId = 101;

  @override
  WritingHand read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WritingHand.left;
      case 1:
        return WritingHand.right;
      default:
        return WritingHand.left;
    }
  }

  @override
  void write(BinaryWriter writer, WritingHand obj) {
    switch (obj) {
      case WritingHand.left:
        writer.writeByte(0);
        break;
      case WritingHand.right:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WritingHandAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
