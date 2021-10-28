// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kana_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KanaTypeAdapter extends TypeAdapter<KanaType> {
  @override
  final int typeId = 100;

  @override
  KanaType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return KanaType.none;
      case 1:
        return KanaType.hiragana;
      case 2:
        return KanaType.katakana;
      case 3:
        return KanaType.both;
      default:
        return KanaType.none;
    }
  }

  @override
  void write(BinaryWriter writer, KanaType obj) {
    switch (obj) {
      case KanaType.none:
        writer.writeByte(0);
        break;
      case KanaType.hiragana:
        writer.writeByte(1);
        break;
      case KanaType.katakana:
        writer.writeByte(2);
        break;
      case KanaType.both:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is KanaTypeAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
