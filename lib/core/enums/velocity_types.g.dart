// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'velocity_types.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VelocityTypesAdapter extends TypeAdapter<VelocityTypes> {
  @override
  final int typeId = 24;

  @override
  VelocityTypes read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return VelocityTypes.slow;
      case 1:
        return VelocityTypes.mid;
      case 2:
        return VelocityTypes.fast;
      default:
        return VelocityTypes.slow;
    }
  }

  @override
  void write(BinaryWriter writer, VelocityTypes obj) {
    switch (obj) {
      case VelocityTypes.slow:
        writer.writeByte(0);
        break;
      case VelocityTypes.mid:
        writer.writeByte(1);
        break;
      case VelocityTypes.fast:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VelocityTypesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
