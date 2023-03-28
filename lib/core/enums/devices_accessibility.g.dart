// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices_accessibility.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DevicesAccessibilityAdapter extends TypeAdapter<DevicesAccessibility> {
  @override
  final int typeId = 22;

  @override
  DevicesAccessibility read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return DevicesAccessibility.none;
      case 1:
        return DevicesAccessibility.press;
      case 2:
        return DevicesAccessibility.scroll;
      case 3:
        return DevicesAccessibility.sipuff;
      default:
        return DevicesAccessibility.none;
    }
  }

  @override
  void write(BinaryWriter writer, DevicesAccessibility obj) {
    switch (obj) {
      case DevicesAccessibility.none:
        writer.writeByte(0);
        break;
      case DevicesAccessibility.press:
        writer.writeByte(1);
        break;
      case DevicesAccessibility.scroll:
        writer.writeByte(2);
        break;
      case DevicesAccessibility.sipuff:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DevicesAccessibilityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
