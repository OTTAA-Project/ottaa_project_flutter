// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'caregiver_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaregiverUserModelAdapter extends TypeAdapter<CaregiverUserModel> {
  @override
  final int typeId = 14;

  @override
  CaregiverUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaregiverUserModel(
      id: fields[0] as String,
      settings: fields[1] as UserSettings,
      type: fields[2] as UserType,
      users: (fields[3] as Map).cast<String, CaregiverUsers>(),
      email: fields[4] as String,
    )..currentToken = fields[5] as DeviceToken?;
  }

  @override
  void write(BinaryWriter writer, CaregiverUserModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.settings)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.users)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.currentToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaregiverUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CaregiverUsersAdapter extends TypeAdapter<CaregiverUsers> {
  @override
  final int typeId = 16;

  @override
  CaregiverUsers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaregiverUsers(
      id: fields[0] as String,
      alias: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CaregiverUsers obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.alias);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaregiverUsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
