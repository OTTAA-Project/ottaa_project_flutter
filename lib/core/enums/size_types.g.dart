// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of 'size_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SizeTypesAdapter extends TypeAdapter<SizeTypes> {
  @override
  final int typeId = 25;

  @override
  SizeTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SizeTypes.small;
      case 1:
        return SizeTypes.mid;
      case 2:
        return SizeTypes.big;
      default:
        return SizeTypes.small;
    }
  }

  @override
  void write(BinaryWriter writer, SizeTypes obj) {
    switch (obj) {
      case SizeTypes.small:
        writer.writeByte(0);
        break;
      case SizeTypes.mid:
        writer.writeByte(1);
        break;
      case SizeTypes.big:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SizeTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
