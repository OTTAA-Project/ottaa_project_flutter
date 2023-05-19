// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'display_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DisplayTypesAdapter extends TypeAdapter<DisplayTypes> {
  @override
  final int typeId = 21;

  @override
  DisplayTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DisplayTypes.grid;
      case 1:
        return DisplayTypes.tab;
      default:
        return DisplayTypes.grid;
    }
  }

  @override
  void write(BinaryWriter writer, DisplayTypes obj) {
    switch (obj) {
      case DisplayTypes.grid:
        writer.writeByte(0);
        break;
      case DisplayTypes.tab:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DisplayTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
