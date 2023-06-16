// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devices_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeviceTokenAdapter extends TypeAdapter<DeviceToken> {
  @override
  final int typeId = 31;

  @override
  DeviceToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeviceToken(
      deviceToken: fields[0] as String,
      lastUsage: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DeviceToken obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.deviceToken)
      ..writeByte(1)
      ..write(obj.lastUsage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeviceTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
