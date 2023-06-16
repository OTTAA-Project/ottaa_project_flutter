// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of 'sweep_modes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SweepModesAdapter extends TypeAdapter<SweepModes> {
  @override
  final int typeId = 23;

  @override
  SweepModes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return SweepModes.elements;
      case 1:
        return SweepModes.sweep;
      default:
        return SweepModes.elements;
    }
  }

  @override
  void write(BinaryWriter writer, SweepModes obj) {
    switch (obj) {
      case SweepModes.elements:
        writer.writeByte(0);
        break;
      case SweepModes.sweep:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SweepModesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
