// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BaseUserModelAdapter extends TypeAdapter<BaseUserModel> {
  @override
  final int typeId = 18;

  @override
  BaseUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BaseUserModel(
      id: fields[0] as String,
      settings: fields[3] as UserSettings,
      email: fields[6] as String,
      type: fields[5] as UserType,
    );
  }

  @override
  void write(BinaryWriter writer, BaseUserModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.settings)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.email);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
